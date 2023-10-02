part of 'places_bloc.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();
}

class PlacesInitial extends PlacesState {
  @override
  List<Object> get props => [];
}

class PlacesDataState extends PlacesState {
  final FavoriteDataDto currentPlace;
  final List<FavoriteDataDto> favorites;

  const PlacesDataState({
    required this.currentPlace,
    required this.favorites,
  });

  @override
  List<Object> get props => [
        currentPlace,
        favorites,
      ];
}
