// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponseDto _$WeatherResponseDtoFromJson(Map<String, dynamic> json) =>
    WeatherResponseDto(
      id: json['id'] as num,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherResponseDtoToJson(WeatherResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };
