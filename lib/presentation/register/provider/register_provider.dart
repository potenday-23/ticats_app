import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/app/extension/input_extension.dart';
import 'package:ticats_app/app/service/auth_service.dart';
import 'package:ticats_app/domain/entity/auth/member_info_entity.dart';
import 'package:ticats_app/domain/entity/auth/sso_login_entity.dart';

part 'register_provider.g.dart';

@riverpod
class Register extends _$Register {
  @override
  MemberInfoEntity build() {
    final SsoLoginEntity ssoLoginEntity = ref.read(authServiceProvider).value!.sso!;

    return MemberInfoEntity(provider: ssoLoginEntity.socialType, email: ssoLoginEntity.email);
  }

  bool get canSignUp => state.email!.isValidEmail() && state.birthday != null && state.gender!.isNotEmpty;

  void setBirthday(String birth) {
    if (birth.isValidBirth() && birth.length == 6) {
      final century = (int.parse(birth.substring(0, 2)) <= int.parse(DateFormat('yy').format(DateTime.now()))) ? 20 : 19;
      final birthday = DateTime(
        int.parse("$century${birth.substring(0, 2)}"),
        int.parse(birth.substring(2, 4)),
        int.parse(birth.substring(4, 6)),
      );
      state = state.copyWith(birthday: birthday);
    } else {
      state = state.copyWith(birthday: null);
    }
  }

  void setEmail(String email) => state = state.copyWith(email: email);
  void setGender(String gender) => state = state.copyWith(gender: gender);
  void setNickname(String nickname) => state = state.copyWith(nickname: nickname);
  void setMember(MemberInfoEntity member) => state = member;

  void resetAccount() {
    state = state.copyWith(birthday: null, gender: "MALE");
  }
}
