import 'package:either_dart/either.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/http/owm_api/models/api_error.dart';
import 'package:weather/data/http/owm_api/models/api_weather_response_dto.dart';

abstract class ApiDataProvider {
  Future<Either<ApiError, ApiWeatherResponseDto>> getWeather(
      {required final LocationDto location});
}
