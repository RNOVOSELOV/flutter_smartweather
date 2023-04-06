import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/data/geolocation/geo_error.dart';

class Geo {
  Geo();

  FutureOr<bool> serviceIsAvailable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  FutureOr<bool> permissionsIsGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return true;
    }
    return false;
  }

  FutureOr<bool> tryRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine ||
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
    final serviceStatus = await serviceIsAvailable();
    if (!serviceStatus) {
      throw GeoException(error: GeoError.geoServiceDisabled);
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      throw GeoException(error: GeoError.geoPermissionDenied);
    } else if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      throw GeoException(error: GeoError.geoPermissionDeniedForever);
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      timeLimit: const Duration(seconds: 5),
    );
  }

  FutureOr<Placemark?> getPositionAddress(
      {required double latitude, required double longitude}) async {
    List<Placemark> placesList = await placemarkFromCoordinates(
      latitude,
      longitude,
      localeIdentifier: 'ru_RU',
    );
    if (placesList.isEmpty) {
      return null;
    }
    return placesList.first;
  }
}
