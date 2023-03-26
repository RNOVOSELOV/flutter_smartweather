import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/data/geolocation/geo_error.dart';
import 'package:weather/data/dto/location_dto.dart';

class Geo {
  bool serviceEnabled = false;

  Geo();

  FutureOr<bool> checkServiceAvailability() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

  FutureOr<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  FutureOr<Position?> getLastKnownPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return await Geolocator.getLastKnownPosition();
    }
    return null;
  }

  FutureOr<Position> getCurrentPosition() async {
    if (!serviceEnabled) {
      final serviceStatus = await checkServiceAvailability();
      if (!serviceStatus) {
        throw GeoException(error: GeoError.geoServiceDisabled);
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      throw GeoException(error: GeoError.geoPermissionDenied);
    } else if (permission == LocationPermission.deniedForever) {
      throw GeoException(error: GeoError.geoPermissionDeniedForever);
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      timeLimit: const Duration(seconds: 5),
    );
  }

  FutureOr<LocationDto> getPositionAddress(
      {required LocationDto location}) async {
    List<Placemark> placesList = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
      localeIdentifier: 'ru_RU',
    );
    if (placesList.isEmpty) {
      return location;
    }
    final place = placesList.first;
    final location1 = ((place.locality ?? place.subAdministrativeArea) ??
            place.administrativeArea) ??
        'Unknown place';
    final location2 =
        (place.country ?? place.isoCountryCode) ?? 'Unknown country';
    return location.copyWith(location: '$location1, $location2');
  }
}
