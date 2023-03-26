// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinatesResponseDto _$CoordinatesResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CoordinatesResponseDto(
      lat: json['lat'] as num,
      lon: json['lon'] as num,
    );

Map<String, dynamic> _$CoordinatesResponseDtoToJson(
        CoordinatesResponseDto instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };
