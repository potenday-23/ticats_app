import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_entity.freezed.dart';
part 'member_entity.g.dart';

@freezed
class MemberEntity with _$MemberEntity {
  const factory MemberEntity({
    required int id,
    required String email,
    String? nickname,
    DateTime? birthday,
    String? gender,
    @Default(false) bool isMarketingAgree,
    @Default(false) bool isSignup,
    String? accessToken,
  }) = _MemberEntity;

  factory MemberEntity.fromJson(Map<String, Object?> json) => _$MemberEntityFromJson(json);
}
