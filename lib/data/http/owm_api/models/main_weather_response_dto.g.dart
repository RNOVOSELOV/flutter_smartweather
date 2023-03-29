// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_weather_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainWeatherResponseDto _$MainWeatherResponseDtoFromJson(
        Map<String, dynamic> json) =>
    MainWeatherResponseDto(
      temp: json['temp'] as num,
      feelsLike: json['feels_like'] as num,
      tempMin: json['temp_min'] as num,
      tempMax: json['temp_max'] as num,
      pressure: json['pressure'] as num,
      humidity: json['humidity'] as num,
      seaLevel: json['sea_level'] as num?,
      grndLevel: json['grnd_level'] as num?,
    );

Map<String, dynamic> _$MainWeatherResponseDtoToJson(
        MainWeatherResponseDto instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.seaLevel,
      'grnd_level': instance.grndLevel,
    };
