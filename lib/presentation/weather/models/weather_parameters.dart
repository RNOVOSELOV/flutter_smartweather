import 'package:equatable/equatable.dart';
import 'package:weather/data/dto/weather_additional_dto.dart';
import 'package:weather/presentation/weather/helpers.dart';
import 'package:weather/presentation/weather/models/parameter.dart';
import 'package:weather/resources/app_images.dart';
import 'package:weather/resources/app_strings.dart';

class WeatherParameters extends Equatable {
  final Parameter temperatureFeelsLike;
  final Parameter pressure;
  final Parameter humidity;
  final Parameter visibility;
  final Parameter wind;
  final Parameter? windGust;
  final Parameter cloudsInPercent;
  final Parameter sunriseTime;
  final Parameter sunsetTime;
  final Parameter? rainOneHour;
  final Parameter? rainThreeHours;
  final Parameter? snowOneHour;
  final Parameter? snowThreeHours;

  const WeatherParameters._({
    required this.temperatureFeelsLike,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.wind,
    required this.windGust,
    required this.cloudsInPercent,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.rainOneHour,
    required this.rainThreeHours,
    required this.snowOneHour,
    required this.snowThreeHours,
  });

  WeatherParameters.fromRepositoryDto({required WeatherAdditionalDto data})
      : this._(
          temperatureFeelsLike: Parameter(
              value: '${data.temperatureFeelsLike}º',
              description: AppStrings.parameterTemperature,
              iconPath: AppImages.parameterIconThermometer),
          pressure: Parameter(
              value: '${data.pressure} hPa',
              description: AppStrings.parameterPressure,
              iconPath: AppImages.parameterIconPressure),
          humidity: Parameter(
              value: '${data.humidity} %',
              description: Helper.getHumidity(data.humidity),
              iconPath: AppImages.parameterIconDrop),
          visibility: Parameter(
              value: '${data.visibility} м',
              description: data.visibility < 500
                  ? AppStrings.parameterBadVisibility
                  : AppStrings.parameterVisibility,
              iconPath: AppImages.parameterIconVisibility),
          wind: Parameter(
              value: '${data.windSpeed}',
              description: Helper.getWindDirection(data.windDeg),
              iconPath: AppImages.parameterIconWind),
          windGust: data.windGust != null
              ? Parameter(
                  value: '${data.windGust} м/с',
                  description: AppStrings.parameterWindGust,
                  iconPath: AppImages.parameterIconWindGist)
              : null,
          cloudsInPercent: Parameter(
              value: '${data.cloudsInPercent} %',
              description: Helper.getCloudy(data.cloudsInPercent),
              iconPath: AppImages.parameterIconCloudy),
          sunriseTime: Parameter(
              value: '',
              description: Helper.getSunTime(data.sunriseTime),
              iconPath: AppImages.parameterIconSunrise),
          sunsetTime: Parameter(
              value: '',
              description: Helper.getSunTime(data.sunsetTime),
              iconPath: AppImages.parameterIconSunset),
          rainOneHour: data.rainOneHour != null
              ? Parameter(
                  value: '${data.rainOneHour} мм',
                  description: ' Выпало осадков за 1 час',
                  iconPath: AppImages.parameterIconRainDrops)
              : null,
          rainThreeHours: data.rainThreeHours != null
              ? Parameter(
                  value: '${data.rainThreeHours} мм',
                  description: ' Выпало осадков за 3 часа',
                  iconPath: AppImages.parameterIconRainDrops)
              : null,
          snowOneHour: data.snowOneHour == null
              ? Parameter(
                  value: '${data.snowOneHour} мм',
                  description: ' Выпало осадков за 1 час',
                  iconPath: AppImages.parameterIconSnowDrops)
              : null,
          snowThreeHours: data.snowThreeHours != null
              ? Parameter(
                  value: '${data.snowThreeHours} мм',
                  description: ' Выпало осадков за 3 часа',
                  iconPath: AppImages.parameterIconSnowDrops)
              : null,
        );

  @override
  List<Object?> get props => [
        temperatureFeelsLike,
        pressure,
        humidity,
        visibility,
        wind,
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
