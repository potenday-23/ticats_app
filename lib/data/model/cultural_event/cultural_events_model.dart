import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';

import 'cultural_event_model.dart';

part 'cultural_events_model.freezed.dart';
part 'cultural_events_model.g.dart';

@freezed
class CulturalEventsModel with _$CulturalEventsModel {
  const factory CulturalEventsModel({
    @Default("") String searchKeyword,
    @Default("") String resultKeyword,
    required bool isKeywordSame,
    required List<CulturalEventModel> culturalEvents,
  }) = _CulturalEventsModel;

  factory CulturalEventsModel.fromJson(Map<String, Object?> json) => _$CulturalEventsModelFromJson(json);
}

extension CulturalEventsModelX on CulturalEventsModel {
  List<CulturalEventEntity> toEntityList() {
    return List<CulturalEventEntity>.from(culturalEvents.map((e) => e.toEntity()));
  }
}
