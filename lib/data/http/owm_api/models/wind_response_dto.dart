import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'wind_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WindResponseDto extends Equatable {
  final num speed;
  final num deg;
  final num? gust;

  factory WindResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$WindResponseDtoFromJson(json);

  const WindResponseDto({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  Map<String, dynamic> toJson() => _$WindResponseDtoToJson(this);

  @override
  List<Object?> get props => [
        speed,
        deg,
        gust,
      ];
}
