// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDto _$WeatherDtoFromJson(Map<String, dynamic> json) => WeatherDto(
      description: json['description'] as String,
      icon: json['icon'] as String,
      temperature: json['temperature'] as int,
      temperatureMin: json['temperatureMin'] as int,
      temperatureMax: json['temperatureMax'] as int,
    );

Map<String, dynamic> _$WeatherDtoToJson(WeatherDto instance) =>
    <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
      'temperature': instance.temperature,
      'temperatureMin': instance.temperatureMin,
      'temperatureMax': instance.temperatureMax,
    };
