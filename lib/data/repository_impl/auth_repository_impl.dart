import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/app/network/dio_provider.dart';
import 'package:ticats_app/data/data_source/remote/auth_api.dart';
import 'package:ticats_app/data/model/auth/member_model.dart';
import 'package:ticats_app/domain/entity/auth/member_entity.dart';
import 'package:ticats_app/domain/entity/auth/member_info_entity.dart';
import 'package:ticats_app/domain/entity/auth/sso_login_entity.dart';
import 'package:ticats_app/domain/repository/auth_repository.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required AuthAPI api}) : _api = api;

  final AuthAPI _api;

  @override
  Future<MemberEntity> getMe() async {
    final MemberModel response = await _api.getMe();

    return response.toEntity();
  }

  @override
  Future<bool> getNickValid(String nickname) async {
    try {
      Map<String, String> request = {"nickname": nickname};

      await _api.getNickValid(request);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<MemberEntity> login(SsoLoginEntity oauthLogin) async {
    final MemberModel response = await _api.login(oauthLogin);

    return response.toEntity();
  }

  @override
  Future<bool> setFCMToken(String fcmToken) async {
    try {
      Map<String, String> request = {"fcmToken": fcmToken};

      await _api.setFCMToken(request);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<MemberEntity> setUserInfo(MemberInfoEntity memberInfo) async {
    final MemberModel response = await _api.setUserInfo(memberInfo);

    return response.toEntity();
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final api = AuthAPI(ref.read(dioProvider));

  return AuthRepositoryImpl(api: api);
}
