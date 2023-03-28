import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/http/owm_api/api_data_provider.dart';
import 'package:weather/data/http/owm_api/base_api_service.dart';
import 'package:weather/data/http/owm_api/models/api_error.dart';
import 'package:weather/data/http/owm_api/models/api_forecast_response_dto.dart';
import 'package:weather/data/http/owm_api/models/api_weather_response_dto.dart';

class OwmApiService extends BaseApiService implements ApiDataProvider {
  static const String _countForecasts = '8';
  final Dio _dio;
  final String _mode = 'json';
  late final String? _apiKey;

  // TODO move to enum & add multi language support in future
  late final String _language;

  // TODO move to enum & and realize application settings in future
  late final String _units;

  OwmApiService(this._dio) {
    _apiKey = dotenv.env['OPEN_WEATHER_MAP_TOKEN'];
    _language = 'ru';
    _units = 'metric';
  }

  @override
  Future<Either<ApiError, ApiWeatherResponseDto>> getWeather(
      {required final LocationDto location}) async {
    return responseOrError(request: () async {
      final response = await _dio.get(
        '/weather',
        queryParameters: {
          'lat': location.latitude,
          'lon': location.longitude,
          'appid': _apiKey ?? 'nonexistenttoken',
          'mode': _mode,
          'lang': _language,
          'units': _units,
        },
      );
      return ApiWeatherResponseDto.fromJson(response.data);
    });
  }

  @override
  Future<Either<ApiError, ApiForecastResponseDto>> getForecast(
      {required final LocationDto location}) async {
    return responseOrError(request: () async {
      final response = await _dio.get(
        '/forecast',
        queryParameters: {
          'lat': location.latitude,
          'lon': location.longitude,
          'appid': _apiKey ?? 'nonexistenttoken',
          'mode': _mode,
          'lang': _language,
          'units': _units,
          'cnt': _countForecasts,
        },
      );
      return ApiForecastResponseDto.fromJson(response.data);
    });
  }
}
