import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'sys_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OwmSysResponseDto extends Equatable {
  final String country;
  final num sunrise;
  final num sunset;

  factory OwmSysResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$OwmSysResponseDtoFromJson(json);

  const OwmSysResponseDto({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toJson() => _$OwmSysResponseDtoToJson(this);

  @override
  List<Object?> get props => [
        country,
        sunrise,
        sunset,
      ];
}
