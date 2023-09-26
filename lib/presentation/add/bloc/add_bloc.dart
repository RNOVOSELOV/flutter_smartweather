import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/geolocation/geo_error.dart';
import 'package:weather/data/geolocation/geo_repository.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'add_event.dart';

part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  late LocationDto selectedLocation;

  final GeoRepository geoRepository;

  AddBloc({required this.geoRepository}) : super(const AddInitialState()) {
    on<AddPageLoadedEvent>(_onPageLoaded);
    on<AddPageMapPlaceholderSetEvent>(_onMapPlaceholderSet);
  }

  FutureOr<void> _onPageLoaded(
      final AddPageLoadedEvent event, final Emitter<AddState> emit) {
    selectedLocation = event.location;
    emit(AddPlaceholderChangedState(
        inProgress: false, location: selectedLocation));
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
      emit(AddSetPlaceNameState(address: address));
    } on GeoException catch (exception) {
      emit(AddShowGeoErrorState(error: exception.error));
    } catch (err) {
      emit(const AddShowGeoErrorState(error: GeoError.geoNoAddressError));
    } finally {
      emit (const AddLongOperationState(inProgress: false));
    }
  }
}

/*


 */
