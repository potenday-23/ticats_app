import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/app/enum/ticats_event_ordering.enum.dart';
import 'package:ticats_app/app/network/dio_provider.dart';
import 'package:ticats_app/data/data_source/remote/cultural_event_api.dart';
import 'package:ticats_app/data/model/cultural_event/cultural_event_model.dart';
import 'package:ticats_app/data/model/cultural_event/cultural_events_model.dart';
import 'package:ticats_app/data/model/cultural_event/popular_search_keyword_model.dart';
import 'package:ticats_app/data/model/cultural_event/recent_search_keyword_model.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/popular_search_keyword_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/recent_search_keyword_entity.dart';
import 'package:ticats_app/domain/repository/cultural_event_repository.dart';

part 'cultural_event_repository_impl.g.dart';

class CulturalEventRepositoryImpl implements CulturalEventRepository {
  CulturalEventRepositoryImpl({required CulturalEventAPI api}) : _api = api;

  final CulturalEventAPI _api;

  @override
  Future<CulturalEventEntity> getCulturalEventInfo(String id) async {
    CulturalEventModel response = await _api.getCulturalEventInfo(id);
    return response.toEntity();
  }

  @override
  Future<List<CulturalEventEntity>> getCulturalEvents(CulturalEventsSearchEntity queries) async {
    CulturalEventsModel response = await _api.getCulturalEvents(queries);
    return response.toEntityList();
  }

  @override
  Future<List<CulturalEventEntity>> getOpenDateEvents(CulturalEventsSearchEntity queries) async {
    queries = queries.copyWith(isOpened: false, ordering: TicatsEventOrdering.ticketOpenDate);

    CulturalEventsModel response = await _api.getCulturalEvents(queries);
    return response.toEntityList();
  }

  @override
  Future<List<CulturalEventEntity>> getPointEvents(CulturalEventsSearchEntity queries) async {
    queries = queries.copyWith(ordering: TicatsEventOrdering.point);

    CulturalEventsModel response = await _api.getCulturalEvents(queries);
    return response.toEntityList();
  }

  @override
  Future<List<CulturalEventEntity>> getRecommendEvents(CulturalEventsSearchEntity queries) async {
    queries = queries.copyWith(ordering: TicatsEventOrdering.recommend);

    CulturalEventsModel response = await _api.getCulturalEvents(queries);
    return response.toEntityList();
  }

  Future<List<PopularSearchKeywordEntity>> getPopularSearchKeywords() async {
    List<PopularSearchKeywordModel> response = await _api.getPopularSearchKeywords();
    return response.map((e) => e.toEntity()).toList();
  }

  Future<List<RecentSearchKeywordEntity>> getRecentSearchKeywords() async {
    List<RecentSearchKeywordModel> response = await _api.getRecentSearchKeywords();
    return response.map((e) => e.toEntity()).toList();
  }
}

@riverpod
CulturalEventRepository culturalEventRepository(CulturalEventRepositoryRef ref) {
  final api = CulturalEventAPI(ref.read(dioProvider));

  return CulturalEventRepositoryImpl(api: api);
}
