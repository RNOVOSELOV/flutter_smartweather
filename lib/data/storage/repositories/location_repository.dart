import 'dart:convert';
import 'package:weather/data/dto/location_weather_dto.dart';
import 'package:weather/data/storage/local_data_provider.dart';
import 'package:weather/data/storage/repositories/reactive_repository.dart';

class LocationRepository extends ReactiveRepository<LocationWeatherDto> {
  LocationRepository(this._spDataProvider);

  final LocalDataProvider _spDataProvider;

  @override
  LocationWeatherDto convertFromString(String rawItem) =>
      LocationWeatherDto.fromJson(json.decode(rawItem));

  @override
  String convertToString(LocationWeatherDto item) => json.encode(item.toJson());

  @override
  Future<String?> getRawData() => _spDataProvider.getLastLocation();

  @override
  Future<bool> saveRawData(String? item) =>
      _spDataProvider.setCurrentLocation(item);
}
