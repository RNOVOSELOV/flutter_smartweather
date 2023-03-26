import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/weather_dto.dart';

part 'location_weather_dto.g.dart';

@JsonSerializable()
class LocationWeatherDto extends Equatable {
  final LocationDto location;
  final WeatherDto weather;

  const LocationWeatherDto({
    required this.location,
    required this.weather,
  });

  const LocationWeatherDto.initial()
      : this(
          location: const LocationDto.initial(),
          weather: const WeatherDto.initial(),
        );

  LocationWeatherDto copyWith({
    LocationDto? location,
    WeatherDto? weather,
  }) {
    return LocationWeatherDto(
      weather: weather ?? this.weather,
      location: location ?? this.location,
    );
  }

  factory LocationWeatherDto.fromJson(final Map<String, dynamic> json) =>
      _$LocationWeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationWeatherDtoToJson(this);

  @override
  List<Object?> get props => [weather, location];

  @override
  bool? get stringify => true;
}
