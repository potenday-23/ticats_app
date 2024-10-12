import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/app/enum/ticats_event_category.enum.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';
import 'package:ticats_app/domain/usecase/cultural_event_usecases.dart';

part 'event_list_controller.freezed.dart';
part 'event_list_controller.g.dart';

@freezed
sealed class EventListState with _$EventListState {
  const factory EventListState({
    @Default([]) List<CulturalEventEntity> events,
    @Default(CulturalEventsSearchEntity()) CulturalEventsSearchEntity filter,
  }) = _EventListState;
}

@riverpod
class EventListController extends _$EventListController {
  late final CulturalEventUsecases _culturalEventUseCase;

  @override
  Future<EventListState> build({String? categoryName}) async {
    _culturalEventUseCase = ref.read(culturalEventUsecasesProvider);
    final result = await _fetchEvents(
        filter: CulturalEventsSearchEntity(
          categories: [_categoryNameToEnumString(categoryName ?? '')]
        )
    );
    return EventListState(events: result);
  }

  List<CulturalEventEntity> getEventList() {
    if (state.value == null) return [];

    return state.value!.events;
  }

  void setFilter(CulturalEventsSearchEntity filter) {
    state = AsyncValue.data(state.value!.copyWith(filter: filter));
  }

  Future<List<CulturalEventEntity>> _fetchEvents({CulturalEventsSearchEntity? filter}) async {
    final List<CulturalEventEntity> response =
      await _culturalEventUseCase.getEvents.execute(
          filter ?? state.value?.filter ?? const CulturalEventsSearchEntity());
    return response;
  }

  String _categoryNameToEnumString(String categoryName) {
    return TicatsEventCategory.values.firstWhere(
            (e) => e.label == categoryName,
        orElse: () => TicatsEventCategory.values.first,
    ).name;
  }
}
