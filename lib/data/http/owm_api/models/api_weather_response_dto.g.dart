// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_weather_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiWeatherResponseDto _$ApiWeatherResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ApiWeatherResponseDto(
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      main:
          MainWeatherResponseDto.fromJson(json['main'] as Map<String, dynamic>),
      visibility: json['visibility'] as num,
      wind: WindResponseDto.fromJson(json['wind'] as Map<String, dynamic>),
      rain: json['rain'] == null
          ? null
          : RainResponseDto.fromJson(json['rain'] as Map<String, dynamic>),
      snow: json['snow'] == null
          ? null
          : SnowResponseDto.fromJson(json['snow'] as Map<String, dynamic>),
      clouds:
          CloudsResponseDto.fromJson(json['clouds'] as Map<String, dynamic>),
      sys: OwmSysResponseDto.fromJson(json['sys'] as Map<String, dynamic>),
      dt: json['dt'] as int,
      timezone: json['timezone'] as int,
    );

Map<String, dynamic> _$ApiWeatherResponseDtoToJson(
        ApiWeatherResponseDto instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'main': instance.main,
      'visibility': instance.visibility,
      'wind': instance.wind,
      'rain': instance.rain,
      'snow': instance.snow,
      'clouds': instance.clouds,
      'sys': instance.sys,
      'dt': instance.dt,
      'timezone': instance.timezone,
    };
