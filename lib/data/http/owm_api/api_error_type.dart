import 'package:weather/resources/app_strings.dart';

enum ApiErrorType {
  invalidApiKey(code: 401, message: AppStrings.invalidApiKey, canResend: true),
  incorrectRequest(
      code: 404, message: AppStrings.incorrectRequest, canResend: false),
  toMoreRequests(
      code: 429, message: AppStrings.toMoreRequests, canResend: false),
  serverError(code: 500, message: AppStrings.serverError, canResend: true),
  badGateway(code: 502, message: AppStrings.serverError, canResend: true),
  serviceUnavailable(
      code: 503, message: AppStrings.serverError, canResend: true),
  serverUnavailable(
      code: 504, message: AppStrings.serverError, canResend: true),
  unknown(code: -1, message: AppStrings.unknownErrorMessage, canResend: false);

  const ApiErrorType({
    required this.code,
    required this.message,
    required this.canResend,
  });

  final int code;
  final String message;
  final bool canResend;

  static ApiErrorType getByCode(final dynamic code) {
    return ApiErrorType.values.firstWhere(
      (element) => element.code == code,
      orElse: () => ApiErrorType.unknown,
    );
  }
}
