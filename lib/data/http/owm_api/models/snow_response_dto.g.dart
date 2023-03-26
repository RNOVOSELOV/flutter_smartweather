// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snow_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnowResponseDto _$SnowResponseDtoFromJson(Map<String, dynamic> json) =>
    SnowResponseDto(
      oneHour: json['1h'] as num?,
      threeHours: json['3h'] as num?,
    );

Map<String, dynamic> _$SnowResponseDtoToJson(SnowResponseDto instance) =>
    <String, dynamic>{
      '1h': instance.oneHour,
      '3h': instance.threeHours,
    };
