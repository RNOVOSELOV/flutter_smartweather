part of 'add_bloc.dart';

abstract class AddEvent extends Equatable {
  const AddEvent();
}

class AddPageLoadedEvent extends AddEvent {
  const AddPageLoadedEvent({required this.location});

  final LocationDto location;

  @override
  List<Object?> get props => [];
}

class AddPageMapPlaceholderSetEvent extends AddEvent {
  final Point point;

  const AddPageMapPlaceholderSetEvent({required this.point});

  @override
  List<Object?> get props => [point];
}
