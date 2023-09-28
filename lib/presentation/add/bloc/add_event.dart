part of 'add_bloc.dart';

abstract class AddEvent extends Equatable {
  const AddEvent();
}

class AddPageLoadedEvent extends AddEvent {
  const AddPageLoadedEvent({required this.location});

  final LocationDto? location;

  @override
  List<Object?> get props => [];
}

class AddPageMapPlaceholderSetEvent extends AddEvent {
  final Point point;

  const AddPageMapPlaceholderSetEvent({required this.point});

  @override
  List<Object?> get props => [point];
}

class AddPageTextEditChanged extends AddEvent {
  final String value;

  const AddPageTextEditChanged({required this.value});

  @override
  List<Object?> get props => [];
}

class AddPageLocationSelected extends AddEvent {
  const AddPageLocationSelected({required this.point});

  final Point point;

  @override
  List<Object?> get props => [point];
}

class AddPageSelectPoint extends AddEvent {
  const AddPageSelectPoint();

  @override
  List<Object?> get props => [];
}


