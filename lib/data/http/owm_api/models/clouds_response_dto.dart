import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'clouds_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CloudsResponseDto extends Equatable {
  final num all;

  factory CloudsResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$CloudsResponseDtoFromJson(json);

  const CloudsResponseDto({
    required this.all,
  });

  Map<String, dynamic> toJson() => _$CloudsResponseDtoToJson(this);

  @override
  List<Object?> get props => [all];
}
