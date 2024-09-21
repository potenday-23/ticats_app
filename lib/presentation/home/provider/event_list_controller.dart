import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';
import 'package:ticats_app/domain/usecase/cultural_event_usecases.dart';

part 'event_list_controller.freezed.dart';
part 'event_list_controller.g.dart';

enum HomeEventViewType {
  recommend,
  point,
  openDate,
}

@freezed
sealed class EventListState with _$EventListState {
  const factory EventListState({
    @Default([]) List<CulturalEventEntity> openDateEvents,
    @Default([]) List<CulturalEventEntity> pointEvents,
    @Default([]) List<CulturalEventEntity> recommendEvents,
  }) = _EventListState;
}

@riverpod
class EventListController extends _$EventListController {
  late final CulturalEventUsecases _culturalEventUseCase;

  @override
  Future<EventListState> build() async {
    _culturalEventUseCase = ref.read(culturalEventUsecasesProvider);

    return _fetchAllEvents();
  }

  List<CulturalEventEntity> getEventList(HomeEventViewType type) {
    if (state.value == null) return [];

    final List<CulturalEventEntity> eventList = type == HomeEventViewType.recommend
        ? state.value!.recommendEvents
        : type == HomeEventViewType.point
            ? state.value!.pointEvents
            : state.value!.openDateEvents;

    return eventList;
  }

  Future<EventListState> _fetchAllEvents() async {
    final results = await Future.wait([
      _fetchOpenDateEvents(),
      _fetchPointEvents(),
      _fetchRecommendEvents(),
    ]);

    return EventListState(
      openDateEvents: results[0],
      pointEvents: results[1],
      recommendEvents: results[2],
    );
  }

  Future<List<CulturalEventEntity>> _fetchOpenDateEvents() async {
    final List<CulturalEventEntity> response = await _culturalEventUseCase.getOpenDateEvents.execute(const CulturalEventsSearchEntity());
    return response;
  }

  Future<List<CulturalEventEntity>> _fetchPointEvents() async {
    final List<CulturalEventEntity> response = await _culturalEventUseCase.getPointEvents.execute(const CulturalEventsSearchEntity());
    return response;
  }

  Future<List<CulturalEventEntity>> _fetchRecommendEvents() async {
    final List<CulturalEventEntity> response = await _culturalEventUseCase.getRecommendEvents.execute(const CulturalEventsSearchEntity());
    return response;
  }

  Future<void> refreshAllEvents() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchAllEvents);
  }
}
