import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';

abstract class CulturalEventRepository {
  Future<CulturalEventEntity> getCulturalEventInfo(String id);
  Future<List<CulturalEventEntity>> getRecommendEvents(CulturalEventsSearchEntity request);
  Future<List<CulturalEventEntity>> getPointEvents(CulturalEventsSearchEntity request);
  Future<List<CulturalEventEntity>> getOpenDateEvents(CulturalEventsSearchEntity request);
}
