import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_search_keyword_entity.freezed.dart';

part 'recent_search_keyword_entity.g.dart';

@freezed
class RecentSearchKeywordEntity with _$RecentSearchKeywordEntity {
  const factory RecentSearchKeywordEntity({
    required int id,
    @Default("") String keyword,
    @Default(0) int ordering,
  }) = _RecentSearchKeywordEntity;

  factory RecentSearchKeywordEntity.fromJson(Map<String, Object?> json) => _$RecentSearchKeywordEntityFromJson(json);
}