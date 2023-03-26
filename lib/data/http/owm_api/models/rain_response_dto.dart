import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'rain_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RainResponseDto extends Equatable {
  @JsonKey(name: '1h')
  final num? oneHour;
  @JsonKey(name: '3h')
  final num? threeHours;

  factory RainResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$RainResponseDtoFromJson(json);

  const RainResponseDto({
    required this.oneHour,
    required this.threeHours,
  });

  Map<String, dynamic> toJson() => _$RainResponseDtoToJson(this);

  @override
  List<Object?> get props => [
        oneHour,
        threeHours,
      ];
}
