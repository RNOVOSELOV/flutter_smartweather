import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/http/owm_api/models/main_weather_response_dto.dart';
import 'package:weather/data/http/owm_api/models/weather_response_dto.dart';

part 'forecast_item_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ForecastItemResponseDto extends Equatable {
  final num dt;
  final MainWeatherResponseDto main;
  final List<WeatherResponseDto> weather;

  factory ForecastItemResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$ForecastItemResponseDtoFromJson(json);

  const ForecastItemResponseDto({
    required this.dt,
    required this.main,
    required this.weather,
  });

  Map<String, dynamic> toJson() => _$ForecastItemResponseDtoToJson(this);

  @override
  List<Object?> get props => [dt, main, weather];
}
