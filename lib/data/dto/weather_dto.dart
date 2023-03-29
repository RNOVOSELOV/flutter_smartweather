import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/http/owm_api/models/api_weather_response_dto.dart';

part 'weather_dto.g.dart';

@JsonSerializable()
class WeatherDto extends Equatable {
  final int id;
  final String description;
  final String icon;
  final int temperature;
  final int temperatureMin;
  final int temperatureMax;

  const WeatherDto({
    required this.description,
    required this.icon,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.id,
  });

  const WeatherDto.initial()
      : this(
          id: 801,
          description: 'переменная облачность',
          icon: '03n',
          temperature: -6,
          temperatureMin: -10,
          temperatureMax: -5,
        );

  WeatherDto copyWith({
    final int? id,
    final String? description,
    final String? icon,
    final int? temperature,
    final int? temperatureMin,
    final int? temperatureMax,
  }) {
    return WeatherDto(
      id: id ?? this.id,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temperature: temperature ?? this.temperature,
      temperatureMin: temperatureMin ?? this.temperatureMin,
      temperatureMax: temperatureMax ?? this.temperatureMax,
    );
  }

  WeatherDto.fromApiResponse({required ApiWeatherResponseDto response})
      : this(
          id: response.weather.first.id.toInt(),
          description: response.weather.first.description,
          icon: response.weather.first.icon,
          temperature: response.main.temp.toInt(),
          temperatureMin: response.main.tempMin.toInt(),
          temperatureMax: response.main.tempMax.toInt(),
        );

  factory WeatherDto.fromJson(final Map<String, dynamic> json) =>
      _$WeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        description,
        icon,
        temperature,
        temperatureMin,
        temperatureMax,
      ];

  @override
  bool? get stringify => true;
}
