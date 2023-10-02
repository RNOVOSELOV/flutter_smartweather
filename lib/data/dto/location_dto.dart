import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto extends Equatable {
  final double longitude;
  final double latitude;
  final String location;

  const LocationDto({
    required this.latitude,
    required this.longitude,
    required this.location,
  });

  const LocationDto.initial()
      : this(latitude: 55.75, longitude: 37.62, location: '');

  LocationDto.fromPosition({required Position position})
      : this(
            latitude: position.latitude,
            longitude: position.longitude,
            location:
                '${(position.latitude * 100).round() / 100}:${(position.longitude * 100).round() / 100}');

  LocationDto copyWith({
    double? latitude,
    double? longitude,
    String? location,
  }) {
    return LocationDto(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      location: location ?? this.location,
    );
  }

  factory LocationDto.fromJson(final Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);

  @override
  List<Object?> get props => [
        longitude,
        latitude,
        location,
      ];

  @override
  bool? get stringify => true;
}
