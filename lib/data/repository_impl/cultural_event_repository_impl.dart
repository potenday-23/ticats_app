import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/app/network/dio_provider.dart';
import 'package:ticats_app/data/data_source/remote/cultural_event_api.dart';
import 'package:ticats_app/data/model/cultural_event/cultural_event_model.dart';
import 'package:ticats_app/data/model/cultural_event/cultural_events_model.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';
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
  Future<List<CulturalEventEntity>> getOpenDateEvents(CulturalEventsSearchEntity queries) async {
    queries = queries.copyWith(isOpened: false, ordering: "ticketOpenDate");

    CulturalEventsModel response = await _api.getCulturalEvents(queries);
    return response.toEntityList();
  }

  @override
  Future<List<CulturalEventEntity>> getPointEvents(CulturalEventsSearchEntity quries) async {
    quries = quries.copyWith(ordering: "point");

    CulturalEventsModel response = await _api.getCulturalEvents(quries);
    return response.toEntityList();
  }

  @override
  Future<List<CulturalEventEntity>> getRecommendEvents(CulturalEventsSearchEntity quries) async {
    quries = quries.copyWith(ordering: "recommend");

    CulturalEventsModel response = await _api.getCulturalEvents(quries);
    return response.toEntityList();
  }
}

@riverpod
CulturalEventRepository culturalEventRepository(CulturalEventRepositoryRef ref) {
  final api = CulturalEventAPI(ref.read(dioProvider));

  return CulturalEventRepositoryImpl(api: api);
}
