// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastItemResponseDto _$ForecastItemResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ForecastItemResponseDto(
      dt: json['dt'] as num,
      main:
          MainWeatherResponseDto.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastItemResponseDtoToJson(
        ForecastItemResponseDto instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main,
      'weather': instance.weather,
    };
