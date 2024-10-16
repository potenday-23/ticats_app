import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';
import 'package:ticats_app/domain/usecase/cultural_event_usecases.dart';

part 'recommended_event_list_controller.freezed.dart';
part 'recommended_event_list_controller.g.dart';

@freezed
sealed class RecommendedEventListState with _$RecommendedEventListState {
  const factory RecommendedEventListState({
    @Default([]) List<CulturalEventEntity> events,
  }) = _RecommendedEventListState;
}

@riverpod
class RecommendedEventListController extends _$RecommendedEventListController {
  late final CulturalEventUsecases _culturalEventUseCase;

  @override
  Future<RecommendedEventListState> build() async {
    _culturalEventUseCase = ref.read(culturalEventUsecasesProvider);
    return RecommendedEventListState(events: await _fetchEvents());
  }

  List<CulturalEventEntity> getEventList() {
    if (state.value == null) return [];

    return state.value!.events;
  }

  Future<List<CulturalEventEntity>> _fetchEvents() async {
    final List<CulturalEventEntity> response =
      await _culturalEventUseCase.getRecommendEvents.execute(const CulturalEventsSearchEntity());

    return response;
  }
}