import 'dart:convert';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/storage/local_data_provider.dart';
import 'package:weather/data/storage/repositories/reactive_repository.dart';

class LocationRepository extends ReactiveRepository<LocationDto> {
  LocationRepository(this._spDataProvider);

  final LocalDataProvider _spDataProvider;

  @override
  LocationDto convertFromString(String rawItem) =>
      LocationDto.fromJson(json.decode(rawItem));

  @override
  String convertToString(LocationDto item) => json.encode(item.toJson());

  @override
  Future<String?> getRawData() => _spDataProvider.getLastLocation();

  @override
  Future<bool> saveRawData(String? item) =>
      _spDataProvider.setLastLocation(item);
}
