import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/resources/app_strings.dart';

class LocationDto extends Equatable {
  final double longitude;
  final double latitude;
  final String location;

  const LocationDto._(
      {required this.latitude,
      required this.longitude,
      required this.location});

  const LocationDto.initial()
      : this._(
            latitude: 64.550000,
            longitude: 40.533330,
            location: 'Архангельск, Россия');

  LocationDto.fromPosition({required Position position})
      : this._(
            latitude: position.latitude,
            longitude: position.longitude,
            location:
                '${(position.latitude * 100).round() / 100}:${(position.longitude * 100).round() / 100}');

  LocationDto copyWith({
    double? latitude,
    double? longitude,
    String? location,
  }) {
    return LocationDto._(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [latitude, longitude, location];

  @override
  bool? get stringify => true;
}
