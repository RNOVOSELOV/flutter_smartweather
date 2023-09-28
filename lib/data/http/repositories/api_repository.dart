import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:weather/data/dto/forecast_dto.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/location_weather_dto.dart';
import 'package:weather/data/dto/weather_additional_dto.dart';
import 'package:weather/data/dto/weather_dto.dart';
import 'package:weather/data/http/owm_api/api_data_provider.dart';
import 'package:weather/data/http/owm_api/models/api_error.dart';
import 'package:weather/data/http/owm_api/models/api_forecast_response_dto.dart';
import 'package:weather/data/http/owm_api/models/api_weather_response_dto.dart';

class ApiRepository {
  final ApiDataProvider _apiDataProvider;

  ApiRepository(this._apiDataProvider);

  // TODO replace to another object
  Map<String, String> simpleMemoryCache = {};

  Future<Either<ApiError, ApiWeatherResponseDto>> _getWeather(
      final LocationDto location) async {
    final result = await _apiDataProvider.getWeather(location: location);
    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }

  Future<Either<ApiError, ApiForecastResponseDto>> _getForecast(
      final LocationDto location) async {
    final result = await _apiDataProvider.getForecast(location: location);
    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }

  Future<Either<ApiError, LocationWeatherDto>> getWeatherForecast(
      {required LocationDto location}) async {
    String mapKey = location.toString();
    if (simpleMemoryCache.containsKey(mapKey)) {
      final value = simpleMemoryCache[mapKey];
      if (value != null) {
        return Right(LocationWeatherDto.fromJson(json.decode(value)));
      }
    }

    final weather = await _getWeather(location);
    if (weather.isLeft) {
      return Left(weather.left);
    }
    final forecast = await _getForecast(location);
    if (forecast.isLeft) {
      return Left(forecast.left);
    }

    final listForecasts = forecast.right.list
        .map((forecastItemResponse) => ForecastDto.fromApiResponse(
            response: forecastItemResponse, timezone: weather.right.timezone))
        .toList();
    // The api response only min & max value at current moment from several station
    final maxTemperatureInDay = listForecasts
        .reduce(
            (curr, next) => curr.temperature > next.temperature ? curr : next)
        .temperature;
    final minTemperatureInDay = listForecasts
        .reduce(
            (curr, next) => curr.temperature < next.temperature ? curr : next)
        .temperature;

    final weatherDto =
        WeatherDto.fromApiResponse(response: weather.right).copyWith(
      temperatureMin: minTemperatureInDay,
      temperatureMax: maxTemperatureInDay,
    );
    if (location.location.isEmpty) {
      location = location.copyWith(location: weather.right.name);
    }
    LocationWeatherDto data = LocationWeatherDto(
      location: location,
      weather: weatherDto,
      additionalWeather:
          WeatherAdditionalDto.fromApiResponse(response: weather.right),
      forecasts: listForecasts,
      currentTime: weather.right.dt + weather.right.timezone,
    );

    if (!simpleMemoryCache.containsKey(mapKey)) {
      final value = json.encode(data.toJson());
      simpleMemoryCache[mapKey] = value;
      Future.delayed(
        const Duration(seconds: 42),
        () => simpleMemoryCache.remove(mapKey),
      );
    }
    return Right(data);
  }

  Future<Either<ApiError, List<LocationDto>>> getLocations(
      final String locationPart) async {
    final result = await _apiDataProvider.getAddressesByPart(
        locationPartialName: locationPart);
    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right
        .map((location) => LocationDto(
            latitude: location.latitude.toDouble(),
            longitude: location.longitude.toDouble(),
            location: '${location.name}, ${location.state}'))
        .toList());
  }
}
