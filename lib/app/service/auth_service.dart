import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:ticats_app/app/enum/login_provider.enum.dart';
import 'package:ticats_app/domain/entity/auth/sso_login_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  @override
  FutureOr<void> build() {}

  Future<void> login(LoginProvider provider) async {
    final SsoLoginEntity? entity;

    if (provider == LoginProvider.apple) {
      entity = await _loginWithApple();
    } else if (provider == LoginProvider.google) {
      entity = await _loginWithGoogle();
    } else if (provider == LoginProvider.kakao) {
      // TODO: Kakao login
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
}
