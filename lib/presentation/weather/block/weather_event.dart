part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherPageLoaded extends WeatherEvent {
  const WeatherPageLoaded();

  @override
  List<Object?> get props => const [];
}
