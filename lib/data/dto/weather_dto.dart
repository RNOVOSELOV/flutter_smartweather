import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/data/http/owm_api/models/api_weather_response_dto.dart';

part 'weather_dto.g.dart';

@JsonSerializable()
class WeatherDto extends Equatable {
  final String description;
  final String icon;
  final int temperature;
  final int temperatureFeelsLike;
  final int temperatureMin;
  final int temperatureMax;
  final int pressure;
  final int humidity;
  final int visibility;
  final int windSpeed;
  final int windDeg;
  final int? windGust;
  final int cloudsInPercent;
  final int sunriseTime;
  final int sunsetTime;
  final int? rainOneHour;
  final int? rainThreeHours;
  final int? snowOneHour;
  final int? snowThreeHours;

  const WeatherDto({
    required this.description,
    required this.icon,
    required this.temperature,
    required this.temperatureFeelsLike,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.cloudsInPercent,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.rainOneHour,
    required this.rainThreeHours,
    required this.snowOneHour,
    required this.snowThreeHours,
  });

  WeatherDto.fromApiResponse({required ApiWeatherResponseDto response})
      : this(
          description: response.weather.first.description,
          icon: response.weather.first.icon,
          temperature: response.main.temp.toInt(),
          temperatureFeelsLike: response.main.feelsLike.toInt(),
          temperatureMin: response.main.tempMin.toInt(),
          temperatureMax: response.main.tempMax.toInt(),
          pressure: response.main.pressure.toInt(),
          humidity: response.main.humidity.toInt(),
          visibility: response.visibility.toInt(),
          windSpeed: response.wind.speed.toInt(),
          windDeg: response.wind.deg.toInt(),
          windGust:
              response.wind.gust != null ? response.wind.gust!.toInt() : null,
          cloudsInPercent: response.clouds.all.toInt(),
          sunriseTime: response.sys.sunrise.toInt(),
          sunsetTime: response.sys.sunset.toInt(),
          rainOneHour: response.rain != null
              ? (response.rain!.oneHour != null
                  ? response.rain!.oneHour!.toInt()
                  : null)
              : null,
          rainThreeHours: response.rain != null
              ? (response.rain!.threeHours != null
                  ? response.rain!.threeHours!.toInt()
                  : null)
              : null,
          snowOneHour: response.snow != null
              ? (response.snow!.oneHour != null
                  ? response.snow!.oneHour!.toInt()
                  : null)
              : null,
          snowThreeHours: response.snow != null
              ? (response.snow!.threeHours != null
                  ? response.snow!.threeHours!.toInt()
                  : null)
              : null,
        );

  factory WeatherDto.fromJson(final Map<String, dynamic> json) =>
      _$WeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDtoToJson(this);

  @override
  List<Object?> get props => [
        description,
        icon,
        temperature,
        temperatureFeelsLike,
        temperatureMin,
        temperatureMax,
        pressure,
        humidity,
        visibility,
        windSpeed,
        windDeg,
        windGust,
        cloudsInPercent,
        sunriseTime,
        sunsetTime,
        rainOneHour,
        rainThreeHours,
        snowOneHour,
        snowThreeHours,
      ];

  @override
  bool? get stringify => true;
}
