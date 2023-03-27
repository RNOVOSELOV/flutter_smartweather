import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/dto/forecast_dto.dart';
import 'package:weather/data/http/owm_api/models/api_forecast_response_dto.dart';

import 'location_dto.dart';

part 'location_forecast_dto.g.dart';

@JsonSerializable()
class LocationForecastDto extends Equatable {
  final List<ForecastDto> forecasts;
  final LocationDto location;

  const LocationForecastDto({
    required this.forecasts,
    required this.location,
  });

  LocationForecastDto copyWith({
    LocationDto? location,
    List<ForecastDto>? forecasts,
  }) {
    return LocationForecastDto(
      forecasts: forecasts ?? this.forecasts,
      location: location ?? this.location,
    );
  }

  factory LocationForecastDto.fromJson(final Map<String, dynamic> json) =>
      _$LocationForecastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationForecastDtoToJson(this);

  @override
  List<Object?> get props => [forecasts, location];

  @override
  bool? get stringify => true;
}
