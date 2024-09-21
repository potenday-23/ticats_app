import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ticats_app/app/config/app_const.dart';
import 'package:ticats_app/data/model/cultural_event/cultural_event_model.dart';
import 'package:ticats_app/data/model/cultural_event/cultural_events_model.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';

part 'cultural_event_api.g.dart';

@RestApi(baseUrl: "${AppConst.baseUrl}/cultural-events")
abstract class CulturalEventAPI {
  factory CulturalEventAPI(Dio dioBuilder) = _CulturalEventAPI;

  @GET("")
  Future<CulturalEventsModel> getCulturalEvents(
    @Queries(encoded: true) CulturalEventsSearchEntity queries,
  );

  @GET("/{id}")
  Future<CulturalEventModel> getCulturalEventInfo(@Path("id") String id);
}
