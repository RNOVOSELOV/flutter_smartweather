import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/storage/favorites_data_provider.dart';
import 'package:weather/data/storage/local_data_provider.dart';

class SharedPreferenceData implements LocalDataProvider, FavoriteDataProvider {
  static const _locationWithWeatherKey = "location_with_weather_key";
  static const _favoritesInfoKey = "favorites_with_weather_key";

  @override
  Future<String?> getFavorite() => _getItem(_favoritesInfoKey);

  @override
  Future<bool> setFavorite(String? favorites) => _setItem(key: _favoritesInfoKey, item: favorites);

  @override
  Future<String?> getLastLocation() => _getItem(_locationWithWeatherKey);

  @override
  Future<bool> setCurrentLocation(String? location) =>
      _setItem(key: _locationWithWeatherKey, item: location);

  Future<bool> _setItem({
    required final String key,
    required final String? item,
  }) async {
    final sp = await SharedPreferences.getInstance();
    final result = sp.setString(key, item ?? '');
    return result;
  }

  Future<String?> _getItem(
    final String key,
  ) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }
}
