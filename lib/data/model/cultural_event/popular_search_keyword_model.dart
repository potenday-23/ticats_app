import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticats_app/domain/entity/cultural_event/popular_search_keyword_entity.dart';

part 'popular_search_keyword_model.freezed.dart';

part 'popular_search_keyword_model.g.dart';

@freezed
class PopularSearchKeywordModel with _$PopularSearchKeywordModel {
  const factory PopularSearchKeywordModel({
    @Default("") String keyword,
    @Default(0) int ordering,
  }) = _PopularSearchKeywordModel;

  factory PopularSearchKeywordModel.fromJson(Map<String, Object?> json) =>
      _$PopularSearchKeywordModelFromJson(json);
}

extension PopularSearchKeywordModelX on PopularSearchKeywordModel {
  PopularSearchKeywordEntity toEntity() {
    return PopularSearchKeywordEntity(keyword: keyword, ordering: ordering);
  }
}
