part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherPageLoaded extends WeatherEvent {
  const WeatherPageLoaded();

  @override
  List<Object?> get props => [];
}

class WeatherResendQuery extends WeatherEvent {
  const WeatherResendQuery();

  @override
  List<Object?> get props => const [];
}

class SelectFavoriteLocationEvent extends WeatherEvent {
  const SelectFavoriteLocationEvent({required this.locationDto});

  final LocationDto locationDto;

  @override
  List<Object?> get props => [locationDto];
}
