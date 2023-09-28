part of 'add_bloc.dart';

abstract class AddState extends Equatable {
  final bool inProgress;

  const AddState({this.inProgress = false});
}

class AddInitialState extends AddState {
  const AddInitialState() : super(inProgress: true);

  @override
  List<Object> get props => [inProgress];
}

class AddLongOperationState extends AddState {
  const AddLongOperationState({bool inProgress = true})
      : super(inProgress: inProgress);

  @override
  List<Object> get props => [inProgress];
}

class AddPlaceholderChangedState extends AddState {
  final LocationDto location;

  const AddPlaceholderChangedState(
      {required this.location, required super.inProgress});

  @override
  List<Object?> get props => [inProgress, location];
}

class AddSetPlaceNameState extends AddState {
  final String address;

  const AddSetPlaceNameState({required this.address});

  @override
  List<Object> get props => [inProgress, address];
}

class AddShowGeoErrorState extends AddState {
  final GeoError error;

  const AddShowGeoErrorState({required this.error}) : super(inProgress: false);

  @override
  List<Object?> get props => [error, inProgress];
}

class AddReturnPlaceNameState extends AddState {
  final LocationDto location;

  const AddReturnPlaceNameState({required this.location});

  @override
  List<Object> get props => [location];
}
