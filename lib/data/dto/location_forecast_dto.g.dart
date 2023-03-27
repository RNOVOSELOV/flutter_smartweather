// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_forecast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationForecastDto _$LocationForecastDtoFromJson(Map<String, dynamic> json) =>
    LocationForecastDto(
      forecasts: (json['forecasts'] as List<dynamic>)
          .map((e) => ForecastDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationForecastDtoToJson(
        LocationForecastDto instance) =>
    <String, dynamic>{
      'forecasts': instance.forecasts,
      'location': instance.location,
    };
