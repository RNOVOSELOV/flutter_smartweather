import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geocoding_location.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GeocodingLocationDto extends Equatable {
  final String name;
  final String state;
  @JsonKey(name: 'lat')
  final num latitude;
  @JsonKey(name: 'lon')
  final num longitude;

  factory GeocodingLocationDto.fromJson(final Map<String, dynamic> json) =>
      _$GeocodingLocationDtoFromJson(json);

  const GeocodingLocationDto({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.state,
  });

  Map<String, dynamic> toJson() => _$GeocodingLocationDtoToJson(this);

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        name,
        state,
      ];
}
