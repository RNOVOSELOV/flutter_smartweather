// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WindResponseDto _$WindResponseDtoFromJson(Map<String, dynamic> json) =>
    WindResponseDto(
      speed: json['speed'] as num,
      deg: json['deg'] as num,
      gust: json['gust'] as num?,
    );

Map<String, dynamic> _$WindResponseDtoToJson(WindResponseDto instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };
