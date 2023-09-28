import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:weather/di/service_locator.dart';

//https://api.openweathermap.org/data/2.5  /weather?lat={lat}&lon={lon}&appid={API key}
//        api.openweathermap.org/data/2.5  /forecast?lat={lat}&lon={lon}&appid={API key}
class DioBuilder {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.openweathermap.org',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ),
  );

  DioBuilder() {
//    if (kDebugMode) {
    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(printResponseData: true),
        talker: sl.get<Talker>(),
      ),
    );
//    }
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
