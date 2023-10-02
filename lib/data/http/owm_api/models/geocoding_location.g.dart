// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodingLocationDto _$GeocodingLocationDtoFromJson(
        Map<String, dynamic> json) =>
    GeocodingLocationDto(
      latitude: json['lat'] as num,
      longitude: json['lon'] as num,
      name: json['name'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$GeocodingLocationDtoToJson(
        GeocodingLocationDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'state': instance.state,
      'lat': instance.latitude,
      'lon': instance.longitude,
    };
