// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_forecast_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiForecastResponseDto _$ApiForecastResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ApiForecastResponseDto(
      list: (json['list'] as List<dynamic>)
          .map((e) =>
              ForecastItemResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: CityResponseDto.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiForecastResponseDtoToJson(
        ApiForecastResponseDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'city': instance.city,
    };
