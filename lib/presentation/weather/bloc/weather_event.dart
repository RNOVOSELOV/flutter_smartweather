part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherPageLoaded extends WeatherEvent {
  final FavoriteDataDto? data;

  const WeatherPageLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class WeatherResendQuery extends WeatherEvent {
  const WeatherResendQuery();

  @override
  List<Object?> get props => const [];
}

class AddNewPlaceEvent extends WeatherEvent {
  const AddNewPlaceEvent();

  @override
  List<Object?> get props => const [];
}
