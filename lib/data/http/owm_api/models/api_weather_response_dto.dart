import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/data/http/owm_api/models/clouds_response_dto.dart';
import 'package:weather/data/http/owm_api/models/main_weather_response_dto.dart';
import 'package:weather/data/http/owm_api/models/rain_response_dto.dart';
import 'package:weather/data/http/owm_api/models/snow_response_dto.dart';
import 'package:weather/data/http/owm_api/models/sys_response_dto.dart';
import 'package:weather/data/http/owm_api/models/weather_response_dto.dart';
import 'package:weather/data/http/owm_api/models/wind_response_dto.dart';

part 'api_weather_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiWeatherResponseDto extends Equatable {
  final List<WeatherResponseDto> weather;
  final MainWeatherResponseDto main;
  final num visibility;
  final WindResponseDto wind;
  final RainResponseDto? rain;
  final SnowResponseDto? snow;
  final CloudsResponseDto clouds;
  final OwmSysResponseDto sys;

  factory ApiWeatherResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$ApiWeatherResponseDtoFromJson(json);

  const ApiWeatherResponseDto({
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.rain,
    required this.snow,
    required this.clouds,
    required this.sys,
  });

  Map<String, dynamic> toJson() => _$ApiWeatherResponseDtoToJson(this);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        weather,
        main,
        visibility,
        wind,
        rain,
        snow,
        clouds,
        sys,
      ];
}
