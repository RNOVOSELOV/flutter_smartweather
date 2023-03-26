import 'package:weather/resources/app_strings.dart';

enum ApiErrorType {
  invalidApiKey(code: 401, message: AppStrings.invalidApiKey),
  /*
  badRequest(400),
  badRequestPath(404),
  apiPathError(null),
  missingParams("E_MISSING_OR_INVALID_PARAMS"),
  */
  unknown(code: 'unknown', message: AppStrings.unknownErrorMessage);

  const ApiErrorType({
    required this.code,
    required this.message,
  });

  final dynamic code;
  final String message;

  static ApiErrorType getByCode(final dynamic code) {
    return ApiErrorType.values.firstWhere(
      (element) => element.code == code,
      orElse: () => ApiErrorType.unknown,
    );
  }
}
