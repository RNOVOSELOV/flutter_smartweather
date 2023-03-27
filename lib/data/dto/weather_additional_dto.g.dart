// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_additional_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherAdditionalDto _$WeatherAdditionalDtoFromJson(
        Map<String, dynamic> json) =>
    WeatherAdditionalDto(
      temperatureFeelsLike: json['temperatureFeelsLike'] as int,
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

Map<String, dynamic> _$WeatherAdditionalDtoToJson(
        WeatherAdditionalDto instance) =>
    <String, dynamic>{
      'temperatureFeelsLike': instance.temperatureFeelsLike,
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
