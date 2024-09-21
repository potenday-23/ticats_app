import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_entity.freezed.dart';
part 'place_entity.g.dart';

@freezed
class PlaceEntity with _$PlaceEntity {
  const factory PlaceEntity({
    @Default("") String title,
    @Default("") String address,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
  }) = _PlaceEntity;

  factory PlaceEntity.fromJson(Map<String, Object?> json) => _$PlaceEntityFromJson(json);
}
