import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

//https://api.openweathermap.org/data/2.5  /weather?lat={lat}&lon={lon}&appid={API key}
//        api.openweathermap.org/data/2.5  /forecast?lat={lat}&lon={lon}&appid={API key}
class DioBuilder {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.openweathermap.org/data/2.5',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ),
  );

  DioBuilder() {
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          request: false,
          requestHeader: true,
          requestBody: false,
          responseHeader: true,
          responseBody: false,
          error: true,
        ),
      );
    }
  }

  Dio build() => _dio;

  DioBuilder addCacheInterceptor() {
    /*
    TODO Realized manually in ApiRepository
    final options = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.forceCache,
      maxStale: const Duration(seconds: 42),
      priority: CachePriority.high,
    );
    _dio.interceptors.add(DioCacheInterceptor(options: options));
    */
    return this;
  }

  DioBuilder addHeaderParameters() {
//    _dio.options.contentType = 'application/json';
//    _dio.options.headers['Content-Type'] = 'application/json';
//    _dio.options.headers['User-Agent'] = 'PostmanRuntime/7.30.0';
    return this;
  }
}
