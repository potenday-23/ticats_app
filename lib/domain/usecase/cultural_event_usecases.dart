import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/data/repository_impl/cultural_event_repository_impl.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';
import 'package:ticats_app/domain/repository/cultural_event_repository.dart';

part 'cultural_event_usecases.g.dart';

class CulturalEventUsecases {
  CulturalEventUsecases({required CulturalEventRepository repository}) : _repository = repository;

  final CulturalEventRepository _repository;

  GetEventInfo get getEventInfo => GetEventInfo(_repository);
  GetOpenDateEvents get getOpenDateEvents => GetOpenDateEvents(_repository);
  GetPointEvents get getPointEvents => GetPointEvents(_repository);
  GetRecommendEvents get getRecommendEvents => GetRecommendEvents(_repository);
}

class GetEventInfo {
  final CulturalEventRepository _repository;

  GetEventInfo(this._repository);

  Future<CulturalEventEntity> execute(String id) async {
    return await _repository.getCulturalEventInfo(id);
  }
}

class GetOpenDateEvents {
  final CulturalEventRepository _repository;

  GetOpenDateEvents(this._repository);

  Future<List<CulturalEventEntity>> execute(CulturalEventsSearchEntity request) async {
    return await _repository.getOpenDateEvents(request);
  }
}

class GetPointEvents {
  final CulturalEventRepository _repository;

  GetPointEvents(this._repository);

  Future<List<CulturalEventEntity>> execute(CulturalEventsSearchEntity request) async {
    return await _repository.getPointEvents(request);
  }
}

class GetRecommendEvents {
  final CulturalEventRepository _repository;

  GetRecommendEvents(this._repository);

  Future<List<CulturalEventEntity>> execute(CulturalEventsSearchEntity request) async {
    return await _repository.getRecommendEvents(request);
  }
}

@riverpod
CulturalEventUsecases culturalEventUsecases(CulturalEventUsecasesRef ref) {
  return CulturalEventUsecases(repository: ref.read(culturalEventRepositoryProvider));
}
