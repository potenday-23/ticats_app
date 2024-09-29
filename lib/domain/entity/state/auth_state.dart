import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticats_app/domain/entity/auth/member_entity.dart';
import 'package:ticats_app/domain/entity/auth/sso_login_entity.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    MemberEntity? memberInfo,
    SsoLoginEntity? sso,
  }) = _AuthState;
}
