import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/location_weather_dto.dart';
import 'package:weather/data/geolocation/geo.dart';
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
    LocationDto location;
    final savedData = await locationDataRepository.getItem();
    if (savedData == null) {
      location = const LocationDto.initial();
    } else {
      location = savedData.location;
      emit(WeatherNewDataState(data: savedData));
    }
    lastLocation = location;
    await updateWeatherData(location, emit);
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
    final result = await apiDataRepository.getWeather(location);
    if (result.isRight) {
      final apiData = result.right;
      emit(WeatherNewDataState(data: apiData));
      await locationDataRepository.setItem(apiData);
    } else {
      final apiError = result.left.errorType;
      emit(WeatherShowError(
          message: apiError.message, canResend: apiError.canResend));
    }
  }
}
