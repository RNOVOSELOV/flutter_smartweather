import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

//https://api.openweathermap.org/data/2.5  /weather?lat={lat}&lon={lon}&appid={API key}
//        api.openweathermap.org/data/2.5  /forecast?lat={lat}&lon={lon}&appid={API key}
class DioBuilder {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.openweathermap.org/data/2.5',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
    ),
  );

  DioBuilder() {
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
      );
    }
  }

  Dio build() => _dio;



  DioBuilder addHeaderParameters() {
//    _dio.options.contentType = 'application/json';
//    _dio.options.headers['Content-Type'] = 'application/json';
//    _dio.options.headers['User-Agent'] = 'PostmanRuntime/7.30.0';
    return this;
  }
}
