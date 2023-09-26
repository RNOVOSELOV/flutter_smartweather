abstract class FavoriteDataProvider {
  Future<bool> setFavorite(final String? favorites);

  Future<String?> getFavorite();
}
