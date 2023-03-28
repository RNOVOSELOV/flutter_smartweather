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
      {required final LocationDto location}) async {
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
    LocationWeatherDto data = LocationWeatherDto(
      location: location,
      weather: weatherDto,
      additionalWeather:
          WeatherAdditionalDto.fromApiResponse(response: weather.right),
      forecasts: listForecasts,
    );
    return Right(data);
  }
}
