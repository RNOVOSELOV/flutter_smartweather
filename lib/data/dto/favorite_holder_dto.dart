import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/data/dto/favorite_data_dto.dart';

part 'favorite_holder_dto.g.dart';

@JsonSerializable()
class FavoriteHolderDto extends Equatable {
  final List<FavoriteDataDto> favorites;

  const FavoriteHolderDto({
    required this.favorites,
  });

  factory FavoriteHolderDto.fromJson(final Map<String, dynamic> json) =>
      _$FavoriteHolderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteHolderDtoToJson(this);

  @override
  List<Object?> get props => [
        favorites,
      ];

  @override
  bool? get stringify => true;
}
