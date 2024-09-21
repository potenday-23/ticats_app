import 'package:freezed_annotation/freezed_annotation.dart';

import 'place_entity.dart';

part 'cultural_event_entity.freezed.dart';
part 'cultural_event_entity.g.dart';

@freezed
class CulturalEventEntity with _$CulturalEventEntity {
  const factory CulturalEventEntity({
    required int id,
    @Default("") String title,
    @Default("") String thumbnailImageUrl,
    @Default("연극") String categoryName,
    PlaceEntity? place,
    String? placeName,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? ticketOpenDate,
    String? runningTime,
    String? summary,
    String? genre,
    String? viewRateName,
    int? likeCount,
    int? visitCount,
    bool? isLiked,
    bool? isOpened,
    List<String>? ticketingSites,
    List<String>? informationList,
  }) = _CulturalEventEntity;

  factory CulturalEventEntity.fromJson(Map<String, Object?> json) => _$CulturalEventEntityFromJson(json);
}
