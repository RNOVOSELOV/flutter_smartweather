// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastDto _$ForecastDtoFromJson(Map<String, dynamic> json) => ForecastDto(
      dt: json['dt'] as int,
      icon: json['icon'] as String,
      temperature: json['temperature'] as int,
      temperatureMin: json['temperatureMin'] as int,
      temperatureMax: json['temperatureMax'] as int,
    );

Map<String, dynamic> _$ForecastDtoToJson(ForecastDto instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'dt': instance.dt,
      'temperature': instance.temperature,
      'temperatureMin': instance.temperatureMin,
      'temperatureMax': instance.temperatureMax,
    };
