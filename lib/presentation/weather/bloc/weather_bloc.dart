import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/location_weather_dto.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/geolocation/geo_error.dart';
import 'package:weather/data/http/repositories/api_repository.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final Geo geolocationService;
  final ApiRepository apiDataRepository;
  final LocationRepository locationDataRepository;

  LocationDto? lastLocation;

  WeatherBloc({
    required this.geolocationService,
    required this.apiDataRepository,
    required this.locationDataRepository,
  }) : super(WeatherInitialState()) {
    on<WeatherPageLoaded>(_onWeatherPageLoaded);
    on<WeatherResendQuery>(_onWeatherResend);
  }

  FutureOr<void> _onWeatherPageLoaded(
    final WeatherPageLoaded event,
    final Emitter<WeatherState> emit,
  ) async {
    emit(WeatherStartLongOperationState());
    // TODO will be nullpointer on change model structure
    final savedData = await locationDataRepository.getItem();
    if (savedData == null) {
      lastLocation = const LocationDto.initial();
    } else {
      lastLocation = savedData.location;
      emit(WeatherNewDataState(data: savedData));
    }
    await updateCurrentLocationCoordinates(emit);
    await updateWeatherData(lastLocation!, emit);
    await Future.delayed(
      const Duration(milliseconds: 200),
      () {
        emit(WeatherEndLongOperationState());
      },
    );
  }

  FutureOr<void> _onWeatherResend(
      final WeatherResendQuery event, final Emitter<WeatherState> emit) async {
    emit(WeatherStartLongOperationState());
    await updateWeatherData(lastLocation!, emit);
    await Future.delayed(
      const Duration(milliseconds: 200),
      () {
        emit(WeatherEndLongOperationState());
      },
    );
  }

  Future<void> updateWeatherData(
    final LocationDto location,
    final Emitter<WeatherState> emit,
  ) async {
    final result =
        await apiDataRepository.getWeatherForecast(location: location);
    if (result.isRight) {
      final apiData = result.right;
      emit(WeatherNewDataState(data: apiData));
      await locationDataRepository.setItem(apiData);
    } else {
      final apiError = result.left.errorType;
      emit(WeatherShowApiError(
          message: apiError.message, canResend: apiError.canResend));
    }
  }

  // TODO create GeoRepository, move error handling logic to it and return Either<GeoError, LocationDto>
  Future<void> updateCurrentLocationCoordinates(
      final Emitter<WeatherState> emit) async {
    try {
      final position = await geolocationService.getCurrentPosition();
      final currLocation = LocationDto.fromPosition(position: position);
      lastLocation =
          await geolocationService.getPositionAddress(location: currLocation);
    } on GeoException catch (exception) {
      emit(WeatherShowGeoError(error: exception.error));
    } on TimeoutException catch (exception) {
      emit(const WeatherShowGeoError(error: GeoError.geoTimeoutError));
    } catch (err) {
      emit(const WeatherShowGeoError(error: GeoError.geoUnknownError));
    }
  }
}
