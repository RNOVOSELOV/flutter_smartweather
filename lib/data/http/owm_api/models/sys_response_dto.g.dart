// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwmSysResponseDto _$OwmSysResponseDtoFromJson(Map<String, dynamic> json) =>
    OwmSysResponseDto(
      country: json['country'] as String,
      sunrise: json['sunrise'] as num,
      sunset: json['sunset'] as num,
    );

Map<String, dynamic> _$OwmSysResponseDtoToJson(OwmSysResponseDto instance) =>
    <String, dynamic>{
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
