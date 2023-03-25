import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/data/geolocation/models/location_dto.dart';
import 'package:weather/data/http/owm_api/base_api_service.dart';
import 'package:weather/data/http/owm_api/models/api_error.dart';
import 'package:weather/data/http/owm_api/models/weather_responce_dto.dart';

class OwmApiService extends BaseApiService {
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

  Future<Either<ApiError, WeatherResponseDto>> getWeather(
      {required final LocationDto location}) async {
    return responseOrError(() async {
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
      return WeatherResponseDto.fromJson(response.data);
    });
  }
}
