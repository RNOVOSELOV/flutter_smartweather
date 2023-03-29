// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationWeatherDto _$LocationWeatherDtoFromJson(Map<String, dynamic> json) =>
    LocationWeatherDto(
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
      weather: WeatherDto.fromJson(json['weather'] as Map<String, dynamic>),
      additionalWeather: WeatherAdditionalDto.fromJson(
          json['additionalWeather'] as Map<String, dynamic>),
      forecasts: (json['forecasts'] as List<dynamic>)
          .map((e) => ForecastDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationWeatherDtoToJson(LocationWeatherDto instance) =>
    <String, dynamic>{
      'location': instance.location,
      'weather': instance.weather,
      'additionalWeather': instance.additionalWeather,
      'forecasts': instance.forecasts,
    };
