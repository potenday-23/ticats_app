import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/app/enum/ticats_event_category.enum.dart';
import 'package:ticats_app/app/enum/ticats_event_ordering.enum.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/popular_search_keyword_entity.dart';
import 'package:ticats_app/domain/entity/cultural_event/recent_search_keyword_entity.dart';
import 'package:ticats_app/domain/usecase/cultural_event_usecases.dart';

part 'searched_event_list_controller.freezed.dart';
part 'searched_event_list_controller.g.dart';

@freezed
sealed class SearchedEventListState with _$SearchedEventListState {
  const factory SearchedEventListState({
    @Default([]) List<CulturalEventEntity> searchedEvents,
    @Default(CulturalEventsSearchEntity()) CulturalEventsSearchEntity filter,
    @Default(false) bool isSubmitted,
    @Default([]) List<RecentSearchKeywordEntity> recentSearchKeywords,
    @Default([]) List<PopularSearchKeywordEntity> popularSearchKeywords,
  }) = _SearchedEventListState;
}

@riverpod
class SearchedEventListController extends _$SearchedEventListController {
  late final CulturalEventUsecases _culturalEventUseCase;

  @override
  Future<SearchedEventListState> build() async {
    _culturalEventUseCase = ref.read(culturalEventUsecasesProvider);
    return SearchedEventListState(
        searchedEvents: await fetchSearchedEvents(),
        recentSearchKeywords: await fetchRecentSearchKeywords(),
        popularSearchKeywords: await fetchPopularSearchKeywords());
  }

  Future<List<CulturalEventEntity>> fetchSearchedEvents(
      {CulturalEventsSearchEntity? filter}) async {
    final List<CulturalEventEntity> response = await _culturalEventUseCase
        .getEvents
        .execute(filter ?? const CulturalEventsSearchEntity());

    return response;
  }

  Future<List<RecentSearchKeywordEntity>> fetchRecentSearchKeywords() async {
    final List<RecentSearchKeywordEntity> response =
        await _culturalEventUseCase.getRecentSearchKeywords.execute();

    return response;
  }

  Future<List<PopularSearchKeywordEntity>> fetchPopularSearchKeywords() async {
    final List<PopularSearchKeywordEntity> response =
        await _culturalEventUseCase.getPopularSearchKeywords.execute();

    return response;
  }

  Future<void> deleteRecentSearchKeyword(int id) async {
    await _culturalEventUseCase.deleteRecentSearchKeyword.execute(id);
    state = AsyncData(state.value!.copyWith(
      recentSearchKeywords: await fetchRecentSearchKeywords(),
    ));
  }

  Future<void> selectOrdering(TicatsEventOrdering ordering) async {
    final newFilter = state.value!.filter.copyWith(ordering: ordering, page: 0);

    state = AsyncValue.data(state.value!.copyWith(
        searchedEvents: await fetchSearchedEvents(filter: newFilter),
        filter: newFilter));
  }

  Future<void> selectCategories(List<TicatsEventCategory> categories) async {
    final newFilter = state.value!.filter
        .copyWith(categories: categories.map((e) => e.name).toList(), page: 0);

    state = AsyncValue.data(state.value!.copyWith(
        searchedEvents: await fetchSearchedEvents(filter: newFilter),
        filter: newFilter));
  }

  Future<void> scrollData() async {
    final newFilter =
        state.value!.filter.copyWith(page: state.value!.filter.page + 1);
    final newEvents = await fetchSearchedEvents(filter: newFilter);

    state = AsyncValue.data(state.value!.copyWith(
        searchedEvents: [...state.value!.searchedEvents, ...newEvents],
        filter: newFilter));
  }

  void onSearchTextChanged(String value) async {
    final newFilter = state.value!.filter.copyWith(keyword: value, page: 0);
    state = AsyncData(state.value!.copyWith(
        searchedEvents: await fetchSearchedEvents(filter: newFilter),
        filter: newFilter,
        isSubmitted: false));
  }

  void submit(String value) async {
    final newFilter = state.value!.filter.copyWith(keyword: value, page: 0);
    state = AsyncData(state.value!.copyWith(
        searchedEvents: await fetchSearchedEvents(filter: newFilter),
        filter: newFilter,
        recentSearchKeywords: await fetchRecentSearchKeywords(),
        isSubmitted: true));
  }

  void clickRemoveIcon() async {
    state = AsyncData(state.value!.copyWith(isSubmitted: false));
  }
}
