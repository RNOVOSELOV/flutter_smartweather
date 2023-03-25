import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:weather/data/http/owm_api/api_error_type.dart';
import 'package:weather/data/http/owm_api/models/api_error.dart';

class BaseApiService {
  Future<Either<ApiError, T>> responseOrError<T>(
    AsyncValueGetter<T> request,
  ) async {
    try {
      return Right(await request());
    } catch (e) {
      return Left(_getApiError(e));
    }
  }

  ApiError _getApiError(final dynamic error) {
    if (error is DioError) {
      if (error.type == DioErrorType.response && error.response != null) {
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
