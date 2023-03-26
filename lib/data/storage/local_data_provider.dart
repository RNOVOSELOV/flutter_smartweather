abstract class LocalDataProvider {
  Future<bool> setLastLocation(final String? location);

  Future<String?> getLastLocation();
}
