import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/location_weather_dto.dart';
import 'package:weather/data/geolocation/geo_error.dart';
import 'package:weather/data/geolocation/geo_repository.dart';
import 'package:weather/data/http/repositories/api_repository.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GeoRepository geoRepository;
  final ApiRepository apiDataRepository;
  final LocalWeatherStorageRepository currentLocationWeatherRepository;
  final Talker talker;

  bool isCurrentLocationActive = true;
  LocationDto? lastRequestedLocation;

  WeatherBloc({
    required this.talker,
    required this.geoRepository,
    required this.apiDataRepository,
    required this.currentLocationWeatherRepository,
  }) : super(WeatherInitialState()) {
    on<WeatherPageLoaded>(_onWeatherPageLoaded);
    on<SelectFavoriteLocationEvent>(_onSelectFavoritePlaceEvent);
    on<WeatherResendQuery>(_onWeatherResend);
  }

  FutureOr<void> _onWeatherPageLoaded(
    final WeatherPageLoaded event,
    final Emitter<WeatherState> emit,
  ) async {
    emit(WeatherStartLongOperationState());
    isCurrentLocationActive = true;
    LocationDto location;
    final savedData = await readSavedDataFromSharedPreferences();
    talker.info('Saved data location: ${savedData?.location}');
    if (savedData != null) {
      emit(WeatherDataState(data: savedData));
      location = savedData.location;
    } else {
      emit(const WeatherNoDataState());
      location = const LocationDto.initial();
    }
    final result = await updateCurrentLocationCoordinates(emit);
    if (result != null) {
      location = result;
    }
    talker.info('Updated location: $location');

    await updateWeatherData(location, emit);
    emit(WeatherEndLongOperationState());
  }

  FutureOr<void> _onWeatherResend(
      final WeatherResendQuery event, final Emitter<WeatherState> emit) async {
    if (lastRequestedLocation == null) {
      return;
    }
    emit(WeatherStartLongOperationState());
    isCurrentLocationActive = false;
    await updateWeatherData(lastRequestedLocation!, emit);
    emit(WeatherEndLongOperationState());
  }

  FutureOr<void> _onSelectFavoritePlaceEvent(
      final SelectFavoriteLocationEvent event,
      final Emitter<WeatherState> emit) async {
    // emit(WeatherStartLongOperationState());
    isCurrentLocationActive = false;
    talker.info('Favorite location: ${event.locationDto}');
    await updateWeatherData(event.locationDto, emit);
    // emit(WeatherEndLongOperationState());
  }

  FutureOr<LocationWeatherDto?> readSavedDataFromSharedPreferences() async {
    try {
      return await currentLocationWeatherRepository.getItem();
    } catch (_) {
      // for future migration ... will be nullpointer if LocationWeatherDto model will be changed
      return null;
    }
  }

  FutureOr<LocationDto?> updateCurrentLocationCoordinates(
      final Emitter<WeatherState> emit) async {
    final result = await geoRepository.getCurrentLocation();
    if (result.isLeft) {
      emit(WeatherShowGeoError(error: result.left));
      return null;
    }
    return result.right;
  }

  FutureOr<void> updateWeatherData(
    final LocationDto location,
    final Emitter<WeatherState> emit,
  ) async {
    lastRequestedLocation = location;
    final result =
        await apiDataRepository.getWeatherForecast(location: location);
    if (result.isRight) {
      emit(WeatherDataState(data: result.right));
      if (isCurrentLocationActive) {
        await currentLocationWeatherRepository.setItem(result.right);
      }
    } else {
      final apiError = result.left.errorType;
      emit(WeatherShowApiError(
          message: apiError.message, canResend: apiError.canResend));
    }
  }
}
