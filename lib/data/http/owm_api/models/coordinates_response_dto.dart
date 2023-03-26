import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'coordinates_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CoordinatesResponseDto extends Equatable {
  final num lat;
  final num lon;

  factory CoordinatesResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$CoordinatesResponseDtoFromJson(json);

  const CoordinatesResponseDto({
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toJson() => _$CoordinatesResponseDtoToJson(this);

  @override
  List<Object?> get props => [lat, lon];
}
