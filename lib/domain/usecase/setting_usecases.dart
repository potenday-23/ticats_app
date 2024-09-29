import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/data/repository_impl/setting_repository_impl.dart';
import 'package:ticats_app/domain/repository/setting_repository.dart';

part 'setting_usecases.g.dart';

class SettingUsecases {
  SettingUsecases({required SettingRepository repository}) : _repository = repository;

  final SettingRepository _repository;

  LoadSettingUseCase get loadSetting => LoadSettingUseCase(_repository);
  UpdateSettingUseCase get updateSetting => UpdateSettingUseCase(_repository);
  LoadSecureSettingUseCase get loadSecureSetting => LoadSecureSettingUseCase(_repository);
  UpdateSecureSettingUseCase get updateSecureSetting => UpdateSecureSettingUseCase(_repository);
}

class ClearSettingUseCase {
  final SettingRepository _repository;

  ClearSettingUseCase(this._repository);

  Future<void> execute() async {
    return await _repository.clearSetting();
  }
}

class LoadSettingUseCase {
  final SettingRepository _repository;

  LoadSettingUseCase(this._repository);

  dynamic execute(String key) {
    return _repository.loadSetting(key);
  }
}

class UpdateSettingUseCase {
  final SettingRepository _repository;

  UpdateSettingUseCase(this._repository);

  Future<void> execute(String key, dynamic value) async {
    return await _repository.updateSetting(key, value);
  }
}

class ClearSecureSettingUseCase {
  final SettingRepository _repository;

  ClearSecureSettingUseCase(this._repository);

  Future<void> execute() async {
    return await _repository.clearSecureSetting();
  }
}

class LoadSecureSettingUseCase {
  final SettingRepository _repository;

  LoadSecureSettingUseCase(this._repository);

  Future<String?> execute(String key) async {
    return await _repository.loadSecureSetting(key);
  }
}

class UpdateSecureSettingUseCase {
  final SettingRepository _repository;

  UpdateSecureSettingUseCase(this._repository);

  Future<void> execute(String key, String value) async {
    return await _repository.updateSecureSetting(key, value);
  }
}

@riverpod
SettingUsecases settingUsecases(SettingUsecasesRef ref) {
  return SettingUsecases(repository: ref.watch(settingRepositoryProvider));
}
