import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location_weather_dto.dart';

part 'favorite_data_dto.g.dart';

@JsonSerializable()
class FavoriteDataDto extends Equatable {
  final double longitude;
  final double latitude;
  final String location;
  final int temperature;
  final String icon;

  const FavoriteDataDto(
      {required this.temperature,
      required this.icon,
      required this.latitude,
      required this.longitude,
      required this.location});

  FavoriteDataDto copyWith({
    double? latitude,
    double? longitude,
    String? location,
    int? temperature,
    String? icon,
  }) {
    return FavoriteDataDto(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
      icon: icon ?? this.icon,
    );
  }

  FavoriteDataDto.fromLocationWeatherDto({required LocationWeatherDto dto})
      : this(
          location: dto.location.location,
          longitude: dto.location.longitude,
          latitude: dto.location.latitude,
          temperature: dto.weather.temperature,
          icon: 'https://openweathermap.org/img/wn/${dto.weather.icon}@2x.png',
        );

  factory FavoriteDataDto.fromJson(final Map<String, dynamic> json) =>
      _$FavoriteDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteDataDtoToJson(this);

  @override
  List<Object?> get props => [latitude, longitude, location, icon, temperature];

  @override
  bool? get stringify => true;
}
