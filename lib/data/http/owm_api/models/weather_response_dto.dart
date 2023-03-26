import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'weather_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WeatherResponseDto extends Equatable {
  final num id;
  final String main;
  final String description;
  final String icon;

  factory WeatherResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$WeatherResponseDtoFromJson(json);

  const WeatherResponseDto({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  Map<String, dynamic> toJson() => _$WeatherResponseDtoToJson(this);

  @override
  List<Object?> get props => [id, main, description, icon];
}
