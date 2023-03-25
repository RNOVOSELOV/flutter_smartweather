import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'weather_responce_dto.g.dart';

@JsonSerializable()
class WeatherResponseDto extends Equatable {
  factory WeatherResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$WeatherResponseDtoFromJson(json);

  const WeatherResponseDto();

  Map<String, dynamic> toJson() => _$WeatherResponseDtoToJson(this);

  @override
  List<Object?> get props => [];
}
