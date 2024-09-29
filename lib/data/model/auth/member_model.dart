import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticats_app/domain/entity/auth/member_entity.dart';

part 'member_model.freezed.dart';
part 'member_model.g.dart';

@freezed
class MemberModel with _$MemberModel {
  const factory MemberModel({
    required int id,
    required String email,
    String? nickname,
    DateTime? birthday,
    String? gender,
    @Default(false) bool isMarketingAgree,
    @Default(false) bool isSignup,
    String? accessToken,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, Object?> json) => _$MemberModelFromJson(json);
}

extension MemberModelX on MemberModel {
  MemberEntity toEntity() {
    return MemberEntity(
      id: id,
      email: email,
      nickname: nickname,
      birthday: birthday,
      gender: gender,
      isMarketingAgree: isMarketingAgree,
      isSignup: isSignup,
      accessToken: accessToken,
    );
  }
}
