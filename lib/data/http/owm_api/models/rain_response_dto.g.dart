// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rain_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RainResponseDto _$RainResponseDtoFromJson(Map<String, dynamic> json) =>
    RainResponseDto(
      oneHour: json['1h'] as num?,
      threeHours: json['3h'] as num?,
    );

Map<String, dynamic> _$RainResponseDtoToJson(RainResponseDto instance) =>
    <String, dynamic>{
      '1h': instance.oneHour,
      '3h': instance.threeHours,
    };
