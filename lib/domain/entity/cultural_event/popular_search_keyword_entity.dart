import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_search_keyword_entity.freezed.dart';
part 'popular_search_keyword_entity.g.dart';

@freezed
class PopularSearchKeywordEntity with _$PopularSearchKeywordEntity {
  const factory PopularSearchKeywordEntity({
    @Default("") String keyword,
    @Default(0) int ordering,
  }) = _PopularSearchKeywordEntity;

  factory PopularSearchKeywordEntity.fromJson(Map<String, Object?> json) => _$PopularSearchKeywordEntityFromJson(json);
}

