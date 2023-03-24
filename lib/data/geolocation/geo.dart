import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:weather/data/geolocation/geo_error.dart';

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

  FutureOr<Position> determinePosition() async {
    if (!serviceEnabled) {
      final serviceStatus = await checkServiceAvailability();
      if (!serviceStatus) {
        throw GeoException(error: GeoError.geoServiceDisabled);
      }
    }
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw GeoException(error: GeoError.geoPermissionDenied);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw GeoException(error: GeoError.geoPermissionDeniedForever);
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      timeLimit: const Duration(seconds: 5),
    );
  }
}
