import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/http/owm_api/models/geocoding_location.dart';

part 'geocoding_responce.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GeocodingResponseDto extends Equatable {
  final List<GeocodingLocationDto> locations;

  factory GeocodingResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$GeocodingResponseDtoFromJson(json);

  const GeocodingResponseDto({
    required this.locations,
  });

  Map<String, dynamic> toJson() => _$GeocodingResponseDtoToJson(this);

  @override
  List<Object?> get props => [locations];
}
