// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_holder_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteHolderDto _$FavoriteHolderDtoFromJson(Map<String, dynamic> json) =>
    FavoriteHolderDto(
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => FavoriteDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteHolderDtoToJson(FavoriteHolderDto instance) =>
    <String, dynamic>{
      'favorites': instance.favorites,
    };
