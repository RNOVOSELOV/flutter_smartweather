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

class WeatherNewDataState extends WeatherState {
  final LocationWeatherDto data;

  const WeatherNewDataState({required this.data});

  @override
  List<Object?> get props => [data];
}

class WeatherShowError extends WeatherState {
  final String message;
  final bool canResend;

  const WeatherShowError( {required this.message, required this.canResend});

  @override
  List<Object?> get props => [message, canResend];
}
