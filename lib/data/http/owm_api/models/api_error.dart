import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/data/http/owm_api/api_error_type.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError extends Equatable {
  final dynamic cod;
  final String? message;

  factory ApiError.fromJson(final Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  const ApiError({
    required this.cod,
    this.message,
  });

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  ApiErrorType get errorType => ApiErrorType.getByCode(cod);

  @override
  List<Object?> get props => [cod, message];
}
