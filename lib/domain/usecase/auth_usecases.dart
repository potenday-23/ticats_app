import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/data/repository_impl/auth_repository_impl.dart';
import 'package:ticats_app/domain/entity/auth/member_entity.dart';
import 'package:ticats_app/domain/entity/auth/member_info_entity.dart';
import 'package:ticats_app/domain/entity/auth/sso_login_entity.dart';
import 'package:ticats_app/domain/repository/auth_repository.dart';
import 'package:ticats_app/domain/usecase/setting_usecases.dart';

part 'auth_usecases.g.dart';

const _memberKey = 'member';

class AuthUseCases {
  AuthUseCases({
    required AuthRepository repository,
    required SettingUsecases settingUsecases,
  })  : _repository = repository,
        _settingUsecases = settingUsecases;

  final AuthRepository _repository;
  final SettingUsecases _settingUsecases;

  GetMemberUseCase get getMember => GetMemberUseCase(_repository);
  ValidateNicknameUseCase get validateNickname => ValidateNicknameUseCase(_repository);
  LoginUseCase get login => LoginUseCase(_repository);
  SetFCMTokenUseCase get setFcmToken => SetFCMTokenUseCase(_repository);
  UpdateUserInfoUseCase get updateUserInfo => UpdateUserInfoUseCase(_repository);

  LoadMemberUseCase get loadMember => LoadMemberUseCase(_settingUsecases);
  SaveMemberUseCase get saveMember => SaveMemberUseCase(_settingUsecases);
}

class GetMemberUseCase {
  final AuthRepository _repository;

  GetMemberUseCase(this._repository);

  Future<MemberEntity> execute() => _repository.getMe();
}

class ValidateNicknameUseCase {
  final AuthRepository _repository;

  ValidateNicknameUseCase(this._repository);

  Future<bool> execute(String nickname) => _repository.getNickValid(nickname);
}

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<MemberEntity> execute(SsoLoginEntity oauthLogin) => _repository.login(oauthLogin);
}

class SetFCMTokenUseCase {
  final AuthRepository _repository;

  SetFCMTokenUseCase(this._repository);

  Future<bool> execute(String fcmToken) => _repository.setFCMToken(fcmToken);
}

class UpdateUserInfoUseCase {
  final AuthRepository _repository;

  UpdateUserInfoUseCase(this._repository);

  Future<MemberEntity> execute(MemberInfoEntity memberInfo) => _repository.setUserInfo(memberInfo);
}

class LoadMemberUseCase {
  final SettingUsecases _settingUsecases;

  LoadMemberUseCase(this._settingUsecases);

  Future<MemberEntity?> execute() async {
    final String? userJson = await _settingUsecases.loadSecureSetting.execute(_memberKey);
    return userJson != null ? MemberEntity.fromJson(jsonDecode(userJson)) : null;
  }
}

class SaveMemberUseCase {
  final SettingUsecases _settingUsecases;

  SaveMemberUseCase(this._settingUsecases);

  Future<void> execute(MemberEntity member) async {
    final userJson = jsonEncode(member.toJson());
    await _settingUsecases.updateSecureSetting.execute(_memberKey, userJson);
  }
}

@riverpod
AuthUseCases authUseCases(AuthUseCasesRef ref) {
  return AuthUseCases(
    repository: ref.read(authRepositoryProvider),
    settingUsecases: ref.read(settingUsecasesProvider),
  );
}
