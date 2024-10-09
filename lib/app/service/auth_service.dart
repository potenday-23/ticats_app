import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:ticats_app/app/enum/sso_type.enum.dart';
import 'package:ticats_app/domain/entity/auth/member_entity.dart';
import 'package:ticats_app/domain/entity/auth/sso_login_entity.dart';
import 'package:ticats_app/domain/entity/state/auth_state.dart';
import 'package:ticats_app/domain/usecase/auth_usecases.dart';
import 'package:uuid/uuid.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  AuthUseCases get _authUseCases => ref.read(authUseCasesProvider);

  @override
  FutureOr<AuthState> build() async {
    final MemberEntity? memberInfo = await _authUseCases.loadMember.execute();

    if (memberInfo == null) {
      return const AuthState();
    }

    return AuthState(memberInfo: memberInfo);
  }

  Future<bool> login(SSOType type) async {
    final SsoLoginEntity? ssoEntity;

    if (type == SSOType.apple) {
      ssoEntity = await _loginWithApple();
    } else if (type == SSOType.google) {
      ssoEntity = await _loginWithGoogle();
    } else if (type == SSOType.kakao) {
      ssoEntity = await _loginWithKakao();
    } else {
      ssoEntity = null;
    }

    if (ssoEntity == null) return false;

    MemberEntity memberEntityResponse = await _authUseCases.login.execute(ssoEntity);
    state = AsyncValue.data(state.value!.copyWith(memberInfo: memberEntityResponse, sso: ssoEntity));

    // 회원가입 여부 확인
    if (memberEntityResponse.isSignup) {
      return true;
    } else {
      state = AsyncValue.data(state.value!.copyWith(sso: ssoEntity));
      return false;
    }
  }

  Future<SsoLoginEntity?> _loginWithApple() async {
    AuthorizationCredentialAppleID credential;
    String email = "${const Uuid().v4()}@ticats.com";

    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );

      if (credential.email != null) {
        email = credential.email!;
      }

      return SsoLoginEntity(socialId: credential.userIdentifier!, socialType: 'APPLE', email: email);
    } catch (e) {
      if (kDebugMode) print('애플 로그인 실패: $e');
    }

    return null;
  }

  Future<SsoLoginEntity?> _loginWithGoogle() async {
    try {
      GoogleSignInAccount? credential = await GoogleSignIn(scopes: ['email']).signIn();

      if (credential != null) {
        return SsoLoginEntity(socialId: credential.id, socialType: 'GOOGLE', email: credential.email);
      }
    } catch (e) {
      if (kDebugMode) print('구글 로그인 실패: $e');
    }

    return null;
  }

  Future<SsoLoginEntity?> _loginWithKakao() async {
    User user;

    try {
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }

      user = await UserApi.instance.me();

      return SsoLoginEntity(socialId: user.id.toString(), socialType: 'KAKAO', email: user.kakaoAccount!.email!);
    } catch (e) {
      if (kDebugMode) print('카카오 로그인 실패: $e');
    }

    return null;
  }

  void setMemberInfo(MemberEntity memberInfo) {
    state = AsyncValue.data(state.value!.copyWith(memberInfo: memberInfo));
  }
}
