// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_weather_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainWeatherResponseDto _$MainWeatherResponseDtoFromJson(
        Map<String, dynamic> json) =>
    MainWeatherResponseDto(
      temp: json['temp'] as num,
      feelsLike: json['feels-like'] as num,
      tempMin: json['temp-min'] as num,
      tempMax: json['temp-max'] as num,
      pressure: json['pressure'] as num,
      humidity: json['humidity'] as num,
      seaLevel: json['sea-level'] as num?,
      grndLevel: json['grnd-level'] as num?,
    );

Map<String, dynamic> _$MainWeatherResponseDtoToJson(
        MainWeatherResponseDto instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels-like': instance.feelsLike,
      'temp-min': instance.tempMin,
      'temp-max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea-level': instance.seaLevel,
      'grnd-level': instance.grndLevel,
    };
