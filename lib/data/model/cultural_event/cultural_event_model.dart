import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';

import 'place_model.dart';

part 'cultural_event_model.freezed.dart';
part 'cultural_event_model.g.dart';

@freezed
class CulturalEventModel with _$CulturalEventModel {
  const factory CulturalEventModel({
    required int id,
    @Default("") String title,
    @Default("") String thumbnailImageUrl,
    @Default("연극") String categoryName,
    PlaceModel? place,
    String? placeName,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? ticketOpenDate,
    String? runningTime,
    String? summary,
    String? genre,
    String? viewRateName,
    int? likeCount,
    int? visitCount,
    bool? isLiked,
    bool? isOpened,
    List<String>? ticketingSites,
    List<String>? informationList,
  }) = _CulturalEventModel;

  factory CulturalEventModel.fromJson(Map<String, Object?> json) => _$CulturalEventModelFromJson(json);
}

extension CulturalEventModelX on CulturalEventModel {
  CulturalEventEntity toEntity() {
    return CulturalEventEntity(
      id: id,
      title: title,
      thumbnailImageUrl: thumbnailImageUrl,
      categoryName: categoryName,
      place: place?.toEntity(),
      placeName: placeName,
      startDate: startDate,
      endDate: endDate,
      ticketOpenDate: ticketOpenDate,
      runningTime: runningTime,
      summary: summary,
      genre: genre,
      viewRateName: viewRateName,
      likeCount: likeCount,
      visitCount: visitCount,
      isLiked: isLiked,
      isOpened: isOpened,
      ticketingSites: ticketingSites,
      informationList: informationList,
    );
  }
}
