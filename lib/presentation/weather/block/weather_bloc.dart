import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/http/owm_api/owm_api_service.dart';
import 'package:weather/data/storage/local_data_provider.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final Geo geolocationService;
  final OwmApiService apiService;
  final LocalDataProvider dataService;

  WeatherBloc({
    required this.geolocationService,
    required this.apiService,
    required this.dataService,
  }) : super(WeatherInitial()) {
    on<WeatherPageLoaded>(_onWeatherPageLoaded);
  }

  FutureOr<void> _onWeatherPageLoaded(
    final WeatherPageLoaded event,
    final Emitter<WeatherState> emit,
  ) {

  }
}
