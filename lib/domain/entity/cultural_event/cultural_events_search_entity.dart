import 'package:freezed_annotation/freezed_annotation.dart';

part 'cultural_events_search_entity.freezed.dart';
part 'cultural_events_search_entity.g.dart';

@freezed
class CulturalEventsSearchEntity with _$CulturalEventsSearchEntity {
  const factory CulturalEventsSearchEntity({
    @Default(["ALL"]) List<String> categories,
    bool? isOpened,
    String? keyword,
    double? latitude,
    double? longitude,
    String? ordering,
    @Default(0) int page,
    @Default(10) int size,
  }) = _CulturalEventsSearchEntity;

  factory CulturalEventsSearchEntity.fromJson(Map<String, Object?> json) => _$CulturalEventsSearchEntityFromJson(json);
}
