import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CityResponseDto extends Equatable {
  final num timezone;

  factory CityResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$CityResponseDtoFromJson(json);

  const CityResponseDto({
    required this.timezone,
  });

  Map<String, dynamic> toJson() => _$CityResponseDtoToJson(this);

  @override
  List<Object?> get props => [timezone];
}
