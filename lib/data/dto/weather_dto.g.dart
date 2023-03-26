// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDto _$WeatherDtoFromJson(Map<String, dynamic> json) => WeatherDto(
      description: json['description'] as String,
      icon: json['icon'] as String,
      temperature: json['temperature'] as int,
      temperatureFeelsLike: json['temperatureFeelsLike'] as int,
      temperatureMin: json['temperatureMin'] as int,
      temperatureMax: json['temperatureMax'] as int,
      pressure: json['pressure'] as int,
      humidity: json['humidity'] as int,
      visibility: json['visibility'] as int,
      windSpeed: json['windSpeed'] as int,
      windDeg: json['windDeg'] as int,
      windGust: json['windGust'] as int?,
      cloudsInPercent: json['cloudsInPercent'] as int,
      sunriseTime: json['sunriseTime'] as int,
      sunsetTime: json['sunsetTime'] as int,
      rainOneHour: json['rainOneHour'] as int?,
      rainThreeHours: json['rainThreeHours'] as int?,
      snowOneHour: json['snowOneHour'] as int?,
      snowThreeHours: json['snowThreeHours'] as int?,
    );

Map<String, dynamic> _$WeatherDtoToJson(WeatherDto instance) =>
    <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
      'temperature': instance.temperature,
      'temperatureFeelsLike': instance.temperatureFeelsLike,
      'temperatureMin': instance.temperatureMin,
      'temperatureMax': instance.temperatureMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'windSpeed': instance.windSpeed,
      'windDeg': instance.windDeg,
      'windGust': instance.windGust,
      'cloudsInPercent': instance.cloudsInPercent,
      'sunriseTime': instance.sunriseTime,
      'sunsetTime': instance.sunsetTime,
      'rainOneHour': instance.rainOneHour,
      'rainThreeHours': instance.rainThreeHours,
      'snowOneHour': instance.snowOneHour,
      'snowThreeHours': instance.snowThreeHours,
    };
