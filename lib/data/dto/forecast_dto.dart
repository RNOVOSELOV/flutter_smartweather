import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/http/owm_api/models/api_forecast_response_dto.dart';
import 'package:weather/data/http/owm_api/models/forecast_item_response.dart';

part 'forecast_dto.g.dart';

@JsonSerializable()
class ForecastDto extends Equatable {
  final String icon;
  final int dt;
  final int temperature;
  final int temperatureMin;
  final int temperatureMax;

  const ForecastDto({
    required this.dt,
    required this.icon,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
  });

  ForecastDto.fromApiResponse(
      {required ForecastItemResponseDto response, required int timezone})
      : this(
          dt: response.dt.toInt() + timezone,
          icon:
              'https://openweathermap.org/img/wn/${response.weather.first.icon}@2x.png',
          temperature: response.main.temp.toInt(),
          temperatureMin: response.main.tempMin.toInt(),
          temperatureMax: response.main.tempMax.toInt(),
        );

  factory ForecastDto.fromJson(final Map<String, dynamic> json) =>
      _$ForecastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDtoToJson(this);

  @override
  List<Object?> get props => [
        dt,
        icon,
        temperature,
        temperatureMin,
        temperatureMax,
      ];

  @override
  bool? get stringify => true;
}
