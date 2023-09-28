import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/geolocation/geo_error.dart';
import 'package:weather/data/geolocation/geo_repository.dart';
import 'package:weather/data/http/repositories/api_repository.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'add_event.dart';

part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  late LocationDto? selectedLocation;

  final GeoRepository geoRepository;
  final ApiRepository apiDataRepository;

  LocationDto? newSelectedLocation;

  AddBloc({required this.geoRepository, required this.apiDataRepository})
      : super(const AddInitialState()) {
    on<AddPageLoadedEvent>(_onPageLoaded);
    on<AddPageMapPlaceholderSetEvent>(_onMapPlaceholderSet);
    on<AddPageSelectPoint>(_onMapPointSelected);
    on<AddPageTextEditChanged>(_onMapPointNameChanged,
        transformer: debounceSequential(const Duration(milliseconds: 400)));
  }

  EventTransformer<Event> debounceSequential<Event>(Duration duration) {
    return (events, mapper) =>
        events.debounceTime(duration).asyncExpand(mapper);
  }

  FutureOr<void> _onPageLoaded(
      final AddPageLoadedEvent event, final Emitter<AddState> emit) {
    selectedLocation = event.location;

    if (selectedLocation != null) {
      emit(AddPlaceholderChangedState(
          inProgress: false, location: selectedLocation!));
    }
  }

  Future<FutureOr<void>> _onMapPlaceholderSet(
      final AddPageMapPlaceholderSetEvent event,
      final Emitter<AddState> emit) async {
    emit(const AddLongOperationState());
    try {
      final address = await geoRepository.getLocationAddress(
        latitude: event.point.latitude,
        longitude: event.point.longitude,
      );
      newSelectedLocation = LocationDto(
        latitude: event.point.latitude,
        longitude: event.point.longitude,
        location: address,
      );
      emit(AddSetPlaceNameState(address: address));
    } on GeoException catch (exception) {
      emit(AddShowGeoErrorState(error: exception.error));
    } catch (err) {
      emit(const AddShowGeoErrorState(error: GeoError.geoNoAddressError));
    } finally {
      emit(const AddLongOperationState(inProgress: false));
    }
  }

  FutureOr<void> _onMapPointSelected(
      final AddPageSelectPoint event, final Emitter<AddState> emit) {
    if (newSelectedLocation != null) {
      emit(AddReturnPlaceNameState(location: newSelectedLocation!));
    }
  }

  FutureOr<void> _onMapPointNameChanged(
      final AddPageTextEditChanged event, final Emitter<AddState> emit) async {
    final result = await apiDataRepository.getLocations(event.value);
    if (result.isRight) {
      print('!!! ${result.right}');
      // emit(WeatherDataState(data: result.right));
    } else {
      final apiError = result.left.errorType;
      print('!!! ${result.left}');
      // emit(WeatherShowApiError(
      //     message: apiError.message, canResend: apiError.canResend));
    }
  }
}
