// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_responce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodingResponseDto _$GeocodingResponseDtoFromJson(
        Map<String, dynamic> json) =>
    GeocodingResponseDto(
      locations: (json['locations'] as List<dynamic>)
          .map((e) => GeocodingLocationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeocodingResponseDtoToJson(
        GeocodingResponseDto instance) =>
    <String, dynamic>{
      'locations': instance.locations,
    };
