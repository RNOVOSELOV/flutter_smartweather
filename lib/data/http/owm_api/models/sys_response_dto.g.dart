// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwmSysResponseDto _$OwmSysResponseDtoFromJson(Map<String, dynamic> json) =>
    OwmSysResponseDto(
      type: json['type'] as num,
      id: json['id'] as num,
      country: json['country'] as String,
      sunrise: json['sunrise'] as num,
      sunset: json['sunset'] as num,
    );

Map<String, dynamic> _$OwmSysResponseDtoToJson(OwmSysResponseDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
