import 'dart:convert';

import 'package:weather/data/dto/favorite_holder_dto.dart';
import 'package:weather/data/storage/favorites_data_provider.dart';
import 'package:weather/data/storage/repositories/reactive_repository.dart';

class FavoriteWeatherRepository extends ReactiveRepository<FavoriteHolderDto> {
  FavoriteWeatherRepository(this._spDataProvider);

  final FavoriteDataProvider _spDataProvider;

  @override
  FavoriteHolderDto convertFromString(String rawItem) =>
      FavoriteHolderDto.fromJson(json.decode(rawItem));

  @override
  String convertToString(FavoriteHolderDto item) => json.encode(item.toJson());

  @override
  Future<String?> getRawData() => _spDataProvider.getFavorite();

  @override
  Future<bool> saveRawData(String? item) => _spDataProvider.setFavorite(item);
}
