part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitialState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherStartLongOperationState extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherEndLongOperationState extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherNoDataState extends WeatherState {
  const WeatherNoDataState();

  @override
  List<Object?> get props => [];
}

class WeatherDataState extends WeatherState {
  final LocationWeatherDto data;

  const WeatherDataState({required this.data});

  @override
  List<Object?> get props => [data];
}

class WeatherShowApiError extends WeatherState {
  final String message;
  final bool canResend;

  const WeatherShowApiError({required this.message, required this.canResend});

  @override
  List<Object?> get props => [message, canResend];
}

class WeatherShowGeoError extends WeatherState {
  final GeoError error;

  const WeatherShowGeoError({required this.error});

  @override
  List<Object?> get props => [error];
}

class WeatherAddPlaceState extends WeatherState {
  final LocationDto location;

  const WeatherAddPlaceState({required this.location});

  @override
  List<Object?> get props => [location];
}
