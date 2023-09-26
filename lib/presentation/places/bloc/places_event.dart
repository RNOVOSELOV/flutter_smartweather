part of 'places_bloc.dart';

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();
}

class PlacesPageLoaded extends PlacesEvent {
  const PlacesPageLoaded();

  @override
  List<Object?> get props => const [];
}
