import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:weather/data/http/owm_api/api_error_type.dart';
import 'package:weather/data/http/owm_api/models/api_error.dart';

class BaseApiService {
  Future<Either<ApiError, T>> responseOrError<T>({
    required AsyncValueGetter<T> request,
  }) async {
    try {
      return Right(await request());
    } catch (e) {
//  TODO add response data to crashlytics error notification in future version
//  debugPrint('Location: ${e.location} RESPONSE: ${e.response}');
//    print('ERROR: $e ${e.runtimeType} ${e.toString()}');
      return Left(_getApiError(error: e));
    }
  }

  ApiError _getApiError({
    required final dynamic error,
  }) {
    if (error is DioException) {
      if (error.type == DioExceptionType.badResponse && error.response != null) {
        try {
          final apiError = ApiError.fromJson(error.response!.data);
          return apiError;
        } catch (apiErr) {
          return const ApiError(cod: ApiErrorType.unknown);
        }
      }
    }
    return const ApiError(cod: ApiErrorType.unknown);
  }
}
