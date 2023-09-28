part of 'places_bloc.dart';

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();
}

class PlacesPageLoaded extends PlacesEvent {
  const PlacesPageLoaded();

  @override
  List<Object?> get props => const [];
}

class PlacesAddNewFavoritesLocation extends PlacesEvent {
  final LocationDto locationDto;

  const PlacesAddNewFavoritesLocation({required this.locationDto});

  @override
  List<Object?> get props => [locationDto];
}
