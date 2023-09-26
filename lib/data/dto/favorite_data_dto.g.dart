// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteDataDto _$FavoriteDataDtoFromJson(Map<String, dynamic> json) =>
    FavoriteDataDto(
      temperature: json['temperature'] as int,
      icon: json['icon'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      location: json['location'] as String,
    );

Map<String, dynamic> _$FavoriteDataDtoToJson(FavoriteDataDto instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'location': instance.location,
      'temperature': instance.temperature,
      'icon': instance.icon,
    };
