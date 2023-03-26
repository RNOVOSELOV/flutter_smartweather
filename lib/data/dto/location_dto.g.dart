// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      location: json['location'] as String,
    );

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'location': instance.location,
    };
