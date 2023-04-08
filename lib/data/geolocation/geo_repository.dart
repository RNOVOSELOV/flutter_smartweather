import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/geolocation/geo_error.dart';

class GeoRepository {
  final Geo geo;

  bool geoServiceIsActive = false;
  bool geoPermissionsGranted = false;

  bool get geoServiceIsInWorkingState =>
      geoServiceIsActive && geoPermissionsGranted;

  GeoRepository({required this.geo});

  Future<void> initGeo() async {
    geoServiceIsActive = await geo.serviceIsAvailable();
    geoPermissionsGranted = await geo.permissionsIsGranted();
    if (!geoPermissionsGranted) {
      geoPermissionsGranted = await geo.tryRequestPermission();
    }
    print('!!! GEO INIT $geoServiceIsActive $geoPermissionsGranted ');
  }

  FutureOr<LocationDto?> getLastKnownPosition() async {
    if (!geoServiceIsInWorkingState) {
      return null;
    }
    final position = await geo.getLastKnownPosition();
    if (position != null) {
      return LocationDto.fromPosition(position: position);
    }
    return null;
  }

  FutureOr<Either<GeoError, LocationDto>> getCurrentLocation() async {
    try {
      final position = await geo.getCurrentPosition();
      final currLocation = LocationDto.fromPosition(position: position);
      final placeMark = await geo.getPositionAddress(
        latitude: currLocation.latitude,
        longitude: currLocation.longitude,
      );
      if (placeMark != null) {
        String? location = ((placeMark.locality == null || placeMark.locality!.isEmpty)
            ? placeMark.subAdministrativeArea
            : placeMark.locality);
        if (location == null || location.isEmpty) {
          location = placeMark.administrativeArea;
        }
        final country = (placeMark.country ?? placeMark.isoCountryCode);
        return Right(currLocation.copyWith(location: '$location, $country'));
      }
      return Right(currLocation);
    } on GeoException catch (exception) {
      return Left(exception.error);
    } on TimeoutException {
      return const Left(GeoError.geoTimeoutError);
    } catch (err) {
      return const Left(GeoError.geoUnknownError);
    }
  }
}
