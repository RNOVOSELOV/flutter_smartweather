abstract class LocalDataProvider {
  Future<bool> setCurrentLocation(final String? location);

  Future<String?> getLastLocation();
}
