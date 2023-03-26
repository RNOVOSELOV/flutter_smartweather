import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/dto/location_weather_dto.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/http/owm_api/owm_api_service.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final Geo geolocationService;
  final OwmApiService apiService;
  final LocationRepository dataService;

  WeatherBloc({
    required this.geolocationService,
    required this.apiService,
    required this.dataService,
  }) : super(WeatherInitialState()) {
    on<WeatherPageLoaded>(_onWeatherPageLoaded);
  }

  FutureOr<void> _onWeatherPageLoaded(
    final WeatherPageLoaded event,
    final Emitter<WeatherState> emit,
  ) async {
    final data = await dataService.getItem();

    await Future.delayed(
      const Duration(seconds: 5),
      () => emit(WeatherNewDataState(data: LocationWeatherDto.initial())),
    );
  }
}
