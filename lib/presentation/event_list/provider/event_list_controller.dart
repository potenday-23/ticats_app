import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/app/enum/ticats_event_category.enum.dart';
import 'package:ticats_app/app/enum/ticats_event_ordering.enum.dart';
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
        categories: [_categoryNameToEnumString(categoryName ?? '')],
      ),
    );
    return EventListState(
      events: result,
      filter: CulturalEventsSearchEntity(
        categories: [_categoryNameToEnumString(categoryName ?? '')],
      ),
    );
  }

  List<CulturalEventEntity> getEventList() {
    if (state.value == null) return [];

    return state.value!.events;
  }

  Future<void> selectOrdering(TicatsEventOrdering ordering) async {
    final newFilter = state.value!.filter.copyWith(ordering: ordering);

    state = AsyncValue.data(state.value!.copyWith(events: await _fetchEvents(filter: newFilter), filter: newFilter));
  }

  Future<void> selectCategories(List<TicatsEventCategory> categories) async {
    final newFilter = state.value!.filter.copyWith(
        categories: categories.map((e) => e.name).toList());

    state = AsyncValue.data(state.value!.copyWith(events: await _fetchEvents(filter: newFilter), filter: newFilter));
  }

  Future<void> scrollData() async {
    final newFilter = state.value!.filter.copyWith(page: state.value!.filter.page + 1);
    final newEvents = await _fetchEvents(filter: newFilter);

    state = AsyncValue.data(state.value!.copyWith(events: [...state.value!.events, ...newEvents], filter: newFilter));
  }

  Future<List<CulturalEventEntity>> _fetchEvents({CulturalEventsSearchEntity? filter}) async {
    final List<CulturalEventEntity> response =
        await _culturalEventUseCase.getEvents.execute(filter ?? state.value?.filter ?? const CulturalEventsSearchEntity());
    return response;
  }

  void setFilter(CulturalEventsSearchEntity filter) {
    state = AsyncValue.data(state.value!.copyWith(filter: filter));
  }

  String _categoryNameToEnumString(String categoryName) {
    return TicatsEventCategory.values
        .firstWhere(
          (e) => e.label == categoryName,
          orElse: () => TicatsEventCategory.values.first,
        )
        .name;
  }
}
