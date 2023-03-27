import 'package:either_dart/either.dart';
import 'package:weather/data/dto/forecast_dto.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/location_forecast_dto.dart';
import 'package:weather/data/dto/location_weather_dto.dart';
import 'package:weather/data/dto/weather_additional_dto.dart';
import 'package:weather/data/dto/weather_dto.dart';
import 'package:weather/data/http/owm_api/api_data_provider.dart';
import 'package:weather/data/http/owm_api/models/api_error.dart';

class ApiRepository {
  final ApiDataProvider _apiDataProvider;

  ApiRepository(this._apiDataProvider);

  Future<Either<ApiError, LocationWeatherDto>> getWeather(
      final LocationDto location) async {
    final result = await _apiDataProvider.getWeather(location: location);
    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(LocationWeatherDto(
        location: location,
        weather: WeatherDto.fromApiResponse(response: result.right),
        additionalWeather:
            WeatherAdditionalDto.fromApiResponse(response: result.right)));
  }

  Future<Either<ApiError, LocationForecastDto>> getForecast(
      final LocationDto location) async {
    final result = await _apiDataProvider.getForecast(location: location);
    if (result.isLeft) {
      return Left(result.left);
    }
    final timezone = result.right.city.timezone.toInt();
    final list = result.right.list
        .map((forecastItemResponse) => ForecastDto.fromApiResponse(
            response: forecastItemResponse, timezone: timezone))
        .toList();
    return Right(LocationForecastDto(location: location, forecasts: list));
  }
}
