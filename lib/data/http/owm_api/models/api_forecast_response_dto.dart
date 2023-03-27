import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/http/owm_api/models/city_response_dto.dart';
import 'package:weather/data/http/owm_api/models/forecast_item_response.dart';

part 'api_forecast_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiForecastResponseDto extends Equatable {
  final List<ForecastItemResponseDto> list;
  final CityResponseDto city;

  factory ApiForecastResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$ApiForecastResponseDtoFromJson(json);

  const ApiForecastResponseDto({
    required this.list,
    required this.city,
  });

  Map<String, dynamic> toJson() => _$ApiForecastResponseDtoToJson(this);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        list,
        city,
      ];
}
