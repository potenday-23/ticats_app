import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/data/data_source/local/secure_storage_data_source_impl.dart';
import 'package:ticats_app/data/data_source/local/settings_local_data_source.dart';
import 'package:ticats_app/data/data_source/local/shared_pref_data_source_impl.dart';
import 'package:ticats_app/domain/repository/settings_repository.dart';

part 'settings_repository_impl.g.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._sharedPrefDataSource, this._secureStorageDataSource);

  final SettingsLocalDataSource _sharedPrefDataSource;
  final SettingsLocalDataSource _secureStorageDataSource;

  @override
  Future<void> clearSetting() async {
    await _sharedPrefDataSource.clearSetting();
  }

  @override
  Future<void> clearSecureSetting() async {
    return await _secureStorageDataSource.clearSetting();
  }

  @override
  dynamic loadSetting(String key) {
    return _sharedPrefDataSource.loadSetting(key);
  }

  @override
  Future<void> updateSetting(String key, dynamic value) async {
    await _sharedPrefDataSource.updateSetting(key, value);
  }

  @override
  Future<String?> loadSecureSetting(String key) async {
    return await _secureStorageDataSource.loadSetting(key) as String?;
  }

  @override
  Future<void> updateSecureSetting(String key, String value) async {
    await _secureStorageDataSource.updateSetting(key, value);
  }
}

@Riverpod(keepAlive: true)
Future<void> initializeSettings(InitializeSettingsRef ref) async {
  final sharedPrefDataSource = ref.read(sharedPreferencesDataSourceProvider);
  final secureStorageDataSource = ref.read(secureStorageDataSourceProvider);

  await sharedPrefDataSource.init();
  await secureStorageDataSource.init();
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  ref.watch(initializeSettingsProvider);

  final sharedPrefDataSource = ref.read(sharedPreferencesDataSourceProvider);
  final secureStorageDataSource = ref.read(secureStorageDataSourceProvider);

  return SettingsRepositoryImpl(sharedPrefDataSource, secureStorageDataSource);
}
