import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/resources/app_strings.dart';

class LocationDto extends Equatable {
  final double longitude;
  final double latitude;

  LocationDto._({required this.latitude, required this.longitude});

  LocationDto.initial() : this._(latitude: 64.550000, longitude: 40.533330);

  LocationDto.fromPosition({required Position position})
      : this._(latitude: position.latitude, longitude: position.longitude);

  @override
  List<Object?> get props => [latitude, longitude];

  @override
  String toString() {
    return '${AppStrings.geolocationString} - ${AppStrings.latitudeString}: $latitude; ${AppStrings.longitudeString}: $longitude.';
  }
}
