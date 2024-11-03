import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_search_keyword_model.freezed.dart';
part 'popular_search_keyword_model.g.dart';

@freezed
class PopularSearchKeywordModel with _$PopularSearchKeywordModel {
  const factory PopularSearchKeywordModel({
    @Default("") String title,
    @Default(0) int ordering,
  }) = _PopularSearchKeywordModel;

  factory PopularSearchKeywordModel.fromJson(Map<String, Object?> json) => _$PopularSearchKeywordModelFromJson(json);
}