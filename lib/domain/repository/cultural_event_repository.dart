import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/popular_search_keyword_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/recent_search_keyword_entity.dart';

abstract class CulturalEventRepository {
  Future<CulturalEventEntity> getCulturalEventInfo(String id);
  Future<List<CulturalEventEntity>> getCulturalEvents(CulturalEventsSearchEntity request);
  Future<List<CulturalEventEntity>> getRecommendEvents(CulturalEventsSearchEntity request);
  Future<List<CulturalEventEntity>> getPointEvents(CulturalEventsSearchEntity request);
  Future<List<CulturalEventEntity>> getOpenDateEvents(CulturalEventsSearchEntity request);
  Future<List<RecentSearchKeywordEntity>> getRecentSearchKeywords();
  Future<List<PopularSearchKeywordEntity>> getPopularSearchKeywords();
}
