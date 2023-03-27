import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/data/data_converter.dart';
import 'package:weather/data/http/owm_api/models/api_weather_response_dto.dart';
import 'package:weather/data/dto/parameter_dto.dart';
import 'package:weather/resources/app_images.dart';
import 'package:weather/resources/app_strings.dart';

part 'weather_additional_dto.g.dart';

@JsonSerializable()
class WeatherAdditionalDto extends Equatable {
  final int temperatureFeelsLike;
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

  const WeatherAdditionalDto({
    required this.temperatureFeelsLike,
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

  const WeatherAdditionalDto.initial()
      : this(
          temperatureFeelsLike: -5,
          pressure: 1007,
          humidity: 92,
          visibility: 10000,
          windSpeed: 1,
          windDeg: 60,
          windGust: null,
          cloudsInPercent: 40,
          sunriseTime: 1679885702,
          sunsetTime: 1679932293,
          rainOneHour: null,
          rainThreeHours: null,
          snowOneHour: null,
          snowThreeHours: null,
        );

  WeatherAdditionalDto.fromApiResponse(
      {required ApiWeatherResponseDto response})
      : this(
          temperatureFeelsLike: response.main.feelsLike.toInt(),
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

  List<ParameterDto> toParametersList() {
    final list = <ParameterDto>[];
    list.add(ParameterDto(
        value: '$temperatureFeelsLikeº',
        description: AppStrings.parameterTemperature,
        iconPath: AppImages.parameterIconThermometer));
    list.add(ParameterDto(
        value: '$windSpeed м/с',
        description: DataConverter.getWindDirection(windDeg),
        iconPath: AppImages.parameterIconWind));
    if (windGust != null) {
      list.add(ParameterDto(
          value: '$windGust м/с',
          description: AppStrings.parameterWindGust,
          iconPath: AppImages.parameterIconWindGist));
    }
    list.add(ParameterDto(
        value: '$pressure hPa',
        description: DataConverter.getPressure(pressure),
        iconPath: AppImages.parameterIconPressure));
    list.add(ParameterDto(
        value: '$humidity %',
        description: DataConverter.getHumidity(humidity),
        iconPath: AppImages.parameterIconDrop));
    list.add(ParameterDto(
        value: '${visibility/1000} км',
        description: DataConverter.getVisibility(visibility),
        iconPath: AppImages.parameterIconVisibility));
    list.add(ParameterDto(
        value: '$cloudsInPercent %',
        description: DataConverter.getCloudy(cloudsInPercent),
        iconPath: AppImages.parameterIconCloudy));
    list.add(ParameterDto(
        value: '',
        description: DataConverter.getSunTime(sunriseTime),
        iconPath: AppImages.parameterIconSunrise));
    list.add(ParameterDto(
        value: '',
        description: DataConverter.getSunTime(sunsetTime),
        iconPath: AppImages.parameterIconSunset));
    if (rainOneHour != null) {
      list.add(ParameterDto(
          value: '$rainOneHour мм',
          description: ' Выпало осадков за 1 час',
          iconPath: AppImages.parameterIconRainDrops));
    }
    if (rainThreeHours != null) {
      list.add(ParameterDto(
          value: '$rainThreeHours мм',
          description: ' Выпало осадков за 3 часа',
          iconPath: AppImages.parameterIconRainDrops));
    }
    if (snowOneHour != null) {
      list.add(ParameterDto(
          value: '$snowOneHour мм',
          description: ' Выпало осадков за 1 час',
          iconPath: AppImages.parameterIconSnowDrops));
    }
    if (snowThreeHours != null) {
      list.add(ParameterDto(
          value: '$snowThreeHours мм',
          description: ' Выпало осадков за 3 часа',
          iconPath: AppImages.parameterIconSnowDrops));
    }
    return list;
  }

  factory WeatherAdditionalDto.fromJson(final Map<String, dynamic> json) =>
      _$WeatherAdditionalDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherAdditionalDtoToJson(this);

  @override
  List<Object?> get props => [
        temperatureFeelsLike,
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
