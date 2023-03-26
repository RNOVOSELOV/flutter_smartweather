import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'snow_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SnowResponseDto extends Equatable {
  @JsonKey(name: '1h')
  final num? oneHour;
  @JsonKey(name: '3h')
  final num? threeHours;

  factory SnowResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$SnowResponseDtoFromJson(json);

  const SnowResponseDto({
    required this.oneHour,
    required this.threeHours,
  });

  Map<String, dynamic> toJson() => _$SnowResponseDtoToJson(this);

  @override
  List<Object?> get props => [
        oneHour,
        threeHours,
      ];
}
