import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'main_weather_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MainWeatherResponseDto extends Equatable {
  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final num pressure;
  final num humidity;
  final num? seaLevel;
  final num? grndLevel;

  factory MainWeatherResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$MainWeatherResponseDtoFromJson(json);

  const MainWeatherResponseDto({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  Map<String, dynamic> toJson() => _$MainWeatherResponseDtoToJson(this);

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        humidity,
        seaLevel,
        grndLevel,
      ];
}
