part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitialState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherInProgressState extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherNewDataState extends WeatherState {
  final LocationWeatherDto data;

  const WeatherNewDataState({required this.data});

  @override
  List<Object?> get props => [data];
}
