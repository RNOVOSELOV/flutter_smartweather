import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'places_event.dart';

part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesInitial()) {
    on<PlacesPageLoaded>(_onPlacesPageLoaded);
  }

  FutureOr<void> _onPlacesPageLoaded(
      final PlacesPageLoaded event, final Emitter<PlacesState> emit) {

  }
}
