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
  }

  FutureOr<void> _onPlacesPageLoaded(
      final PlacesPageLoaded event, final Emitter<PlacesState> emit) async {
     current = FavoriteDataDto.fromLocationWeatherDto(
        dto: (await currentLocationWeatherRepository.getItem()) ??
            LocationWeatherDto.initial());

    final favHolder = await favoriteRepository.getItem();
    final favorites =
        favHolder != null ? favHolder.favorites : <FavoriteDataDto>[];
    emit(PlacesDataState(currentPlace: current, favorites: favorites));
  }

  FutureOr<void> _onNewPlaceAdded(final PlacesAddNewFavoritesLocation event,
      final Emitter<PlacesState> emit) async {
    final favHolder = await favoriteRepository.getItem();
    final favorites =
        favHolder != null ? favHolder.favorites : <FavoriteDataDto>[];
    favorites.add(FavoriteDataDto(
        temperature: 0,
        icon: '',
        latitude: event.locationDto.latitude,
        longitude: event.locationDto.longitude,
        location: event.locationDto.location));
    await favoriteRepository.setItem(FavoriteHolderDto(favorites: favorites));
    emit(PlacesDataState(currentPlace: current, favorites: favorites));
  }
}
