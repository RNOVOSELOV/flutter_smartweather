import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:weather/data/dto/favorite_data_dto.dart';
import 'package:weather/data/dto/favorite_holder_dto.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/location_weather_dto.dart';
import 'package:weather/data/http/repositories/api_repository.dart';
import 'package:weather/data/storage/repositories/favorite_repository.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';

part 'places_event.dart';

part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final ApiRepository apiDataRepository;
  final LocalWeatherStorageRepository currentLocationWeatherRepository;
  final FavoriteWeatherRepository favoriteRepository;
  final Talker talker;

  late final FavoriteDataDto current;

  PlacesBloc({
    required this.apiDataRepository,
    required this.currentLocationWeatherRepository,
    required this.favoriteRepository,
    required this.talker,
  }) : super(PlacesInitial()) {
    on<PlacesPageLoaded>(_onPlacesPageLoaded);
    on<PlacesAddNewFavoritesLocation>(_onNewPlaceAdded);
    on<PlacesRemoveFavoritesLocation>(_onRemoveFavorite);
  }

  FutureOr<void> _onPlacesPageLoaded(
      final PlacesPageLoaded event, final Emitter<PlacesState> emit) async {
    current = FavoriteDataDto.fromLocationWeatherDto(
        dto: (await currentLocationWeatherRepository.getItem()) ??
            LocationWeatherDto.initial());

    final favHolder = await favoriteRepository.getItem();
    List<FavoriteDataDto> favorites =
        favHolder != null ? favHolder.favorites : <FavoriteDataDto>[];
    emit(PlacesDataState(currentPlace: current, favorites: [...favorites]));

    for (int i = 0; i < favorites.length; i++) {
      var value = favorites.removeAt(i);
      value = await updateWeatherData(
        latitude: value.latitude,
        longitude: value.longitude,
        location: value.location,
      );
      favorites.insert(i, value);
      emit(PlacesDataState(currentPlace: current, favorites: [...favorites]));
    }
    await favoriteRepository.setItem(FavoriteHolderDto(favorites: favorites));
  }

  FutureOr<void> _onNewPlaceAdded(final PlacesAddNewFavoritesLocation event,
      final Emitter<PlacesState> emit) async {
    final favHolder = await favoriteRepository.getItem();
    final favorites =
        favHolder != null ? favHolder.favorites : <FavoriteDataDto>[];

    final newFavoriteValue = await updateWeatherData(
      latitude: event.locationDto.latitude,
      longitude: event.locationDto.longitude,
      location: event.locationDto.location,
    );
    favorites.add(newFavoriteValue);
    await favoriteRepository.setItem(FavoriteHolderDto(favorites: favorites));
    emit(PlacesDataState(currentPlace: current, favorites: favorites));
  }

  Future<FavoriteDataDto> updateWeatherData({
    required final double latitude,
    required final double longitude,
    required final String location,
  }) async {
    final result = await apiDataRepository.getWeatherForecast(
        location: LocationDto(
      latitude: latitude,
      longitude: longitude,
      location: location,
    ));
    if (result.isRight) {
      return FavoriteDataDto.fromLocationWeatherDto(dto: result.right);
    } else {
      return FavoriteDataDto(
        temperature: 0,
        icon: '',
        latitude: latitude,
        longitude: longitude,
        location: location,
      );
    }
  }

  FutureOr<void> _onRemoveFavorite(final PlacesRemoveFavoritesLocation event,
      final Emitter<PlacesState> emit) async {
    final favHolder = await favoriteRepository.getItem();
    List<FavoriteDataDto> favorites =
        favHolder != null ? favHolder.favorites : <FavoriteDataDto>[];

    favorites.removeWhere((element) => element.location == event.location);
    emit(PlacesDataState(currentPlace: current, favorites: [...favorites]));
    await favoriteRepository.setItem(FavoriteHolderDto(favorites: favorites));
  }
}
