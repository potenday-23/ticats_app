import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticats_app/domain/entity/cultural_event/recent_search_keyword_entity.dart';

part 'recent_search_keyword_model.freezed.dart';

part 'recent_search_keyword_model.g.dart';

@freezed
class RecentSearchKeywordModel with _$RecentSearchKeywordModel {
  const factory RecentSearchKeywordModel({
    required int id,
    @Default("") String title,
    @Default(0) int ordering,
  }) = _RecentSearchKeywordModel;

  factory RecentSearchKeywordModel.fromJson(Map<String, Object?> json) =>
      _$RecentSearchKeywordModelFromJson(json);
}

extension RecentSearchKeywordModelX on RecentSearchKeywordModel {
  RecentSearchKeywordEntity toEntity() {
    return RecentSearchKeywordEntity(id: id, title: title, ordering: ordering);
  }
}
