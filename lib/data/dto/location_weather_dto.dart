import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/weather_additional_dto.dart';
import 'package:weather/data/dto/weather_dto.dart';

part 'location_weather_dto.g.dart';

@JsonSerializable()
class LocationWeatherDto extends Equatable {
  final LocationDto location;
  final WeatherDto weather;
  final WeatherAdditionalDto additionalWeather;

  const LocationWeatherDto({
    required this.location,
    required this.weather,
    required this.additionalWeather,
  });

  const LocationWeatherDto.initial()
      : this(
          location: const LocationDto.initial(),
          weather: const WeatherDto.initial(),
          additionalWeather: const WeatherAdditionalDto.initial(),
        );

  LocationWeatherDto copyWith({
    LocationDto? location,
    WeatherDto? weather,
    WeatherAdditionalDto? additional,
  }) {
    return LocationWeatherDto(
      weather: weather ?? this.weather,
      location: location ?? this.location,
      additionalWeather: additional ?? additionalWeather,
    );
  }

  factory LocationWeatherDto.fromJson(final Map<String, dynamic> json) =>
      _$LocationWeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationWeatherDtoToJson(this);

  @override
  List<Object?> get props => [weather, location, additionalWeather];

  @override
  bool? get stringify => true;
}
