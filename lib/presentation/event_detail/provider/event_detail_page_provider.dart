import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/domain/usecase/cultural_event_usecases.dart';

part 'event_detail_page_provider.freezed.dart';
part 'event_detail_page_provider.g.dart';

@freezed
sealed class EventDetailPageState with _$EventDetailPageState {
  const factory EventDetailPageState({
    @Default(CulturalEventEntity(id: 0)) CulturalEventEntity event
  }) = _EventDetailPageState;
}

@riverpod
class EventDetailPageController extends _$EventDetailPageController {
  late final CulturalEventUsecases _culturalEventUseCase;

  @override
  Future<EventDetailPageState> build({required int id}) async {
    _culturalEventUseCase = ref.read(culturalEventUsecasesProvider);

    return EventDetailPageState(
      event: await _fetchEvent(id)
    );
  }

  Future<CulturalEventEntity> _fetchEvent(int id) async {
    final CulturalEventEntity response =
        await _culturalEventUseCase.getEventInfo.execute(id.toString());
    return response;
  }
}
