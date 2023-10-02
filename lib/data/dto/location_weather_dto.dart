import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/dto/forecast_dto.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/weather_additional_dto.dart';
import 'package:weather/data/dto/weather_dto.dart';

part 'location_weather_dto.g.dart';

@JsonSerializable()
class LocationWeatherDto extends Equatable {
  final LocationDto location;
  final WeatherDto weather;
  final WeatherAdditionalDto additionalWeather;
  final List<ForecastDto> forecasts;
  final int currentTime;

  const LocationWeatherDto({
    required this.location,
    required this.weather,
    required this.additionalWeather,
    required this.forecasts,
    required this.currentTime,
  });

  LocationWeatherDto.initial()
      : this(
          location: const LocationDto.initial(),
          weather: const WeatherDto.initial(),
          additionalWeather: const WeatherAdditionalDto.initial(),
          forecasts: <ForecastDto>[],
          currentTime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        );

  LocationWeatherDto copyWith(
      {LocationDto? location,
      WeatherDto? weather,
      WeatherAdditionalDto? additional,
      List<ForecastDto>? forecasts,
      int? secondsSinceEpoch}) {
    return LocationWeatherDto(
      weather: weather ?? this.weather,
      location: location ?? this.location,
      additionalWeather: additional ?? additionalWeather,
      forecasts: forecasts ?? this.forecasts,
      currentTime: secondsSinceEpoch ?? currentTime,
    );
  }

  factory LocationWeatherDto.fromJson(final Map<String, dynamic> json) =>
      _$LocationWeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationWeatherDtoToJson(this);

  @override
  List<Object?> get props => [
        location,
        weather,
        additionalWeather,
        forecasts,
        currentTime,
      ];

  @override
  bool? get stringify => true;
}
