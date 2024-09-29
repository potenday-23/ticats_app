import 'package:ticats_app/domain/entity/auth/member_entity.dart';
import 'package:ticats_app/domain/entity/auth/member_info_entity.dart';
import 'package:ticats_app/domain/entity/auth/sso_login_entity.dart';

abstract class AuthRepository {
  Future<MemberEntity> getMe();
  Future<bool> getNickValid(String nickname);
  Future<MemberEntity> login(SsoLoginEntity oauthLogin);
  Future<bool> setFCMToken(String fcmToken);
  Future<MemberEntity> setUserInfo(MemberInfoEntity memberInfo);
}
