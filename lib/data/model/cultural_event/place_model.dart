import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticats_app/domain/entity/cultural_event/place_entity.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@freezed
class PlaceModel with _$PlaceModel {
  const factory PlaceModel({
    @Default("") String title,
    @Default("") String address,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
  }) = _PlaceModel;

  factory PlaceModel.fromJson(Map<String, Object?> json) => _$PlaceModelFromJson(json);
}

extension PlaceModelX on PlaceModel {
  PlaceEntity toEntity() {
    return PlaceEntity(
      title: title,
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
