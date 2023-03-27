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

  WeatherBloc({
    required this.geolocationService,
    required this.apiDataRepository,
    required this.locationDataRepository,
  }) : super(WeatherInitialState()) {
    on<WeatherPageLoaded>(_onWeatherPageLoaded);
  }

  FutureOr<void> _onWeatherPageLoaded(
    final WeatherPageLoaded event,
    final Emitter<WeatherState> emit,
  ) async {
    LocationDto location = const LocationDto.initial();
    emit(WeatherStartLongOperationState());
    final result = await apiDataRepository.getWeather(location);
    LocationWeatherDto data = result.right;

    emit(WeatherNewDataState(data: data));

    await Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(WeatherEndLongOperationState());
      },
    );
/*
      print('${value.isLeft} ${value.isRight}');
      debugPrint(value.left.toString());
      debugPrint('${value.left.errorType.code} ${value.left.cod}');
      debugPrint('${value.left.errorType.message} ${value.left.message}');
*/

    //final data = await dataService.getItem();
    //
    // await Future.delayed(
    //   const Duration(seconds: 5),
    //       () {
    //     emit(const WeatherNewDataState(data: LocationWeatherDto.initial()));
    //   },
    // );
  }
}
