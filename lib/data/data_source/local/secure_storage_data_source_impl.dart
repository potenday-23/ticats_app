import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'settings_local_data_source.dart';

class SecureStorageDataSourceImpl implements SettingsLocalDataSource {
  SecureStorageDataSourceImpl();

  late FlutterSecureStorage secureStorage;
  final iOptions = const IOSOptions(accessibility: KeychainAccessibility.first_unlock, synchronizable: true);

  @override
  void init() {
    secureStorage = FlutterSecureStorage(iOptions: iOptions);
  }

  @override
  Future<void> clearSetting() async {
    await secureStorage.deleteAll();
  }

  @override
  dynamic loadSetting(String key) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> updateSetting(String key, dynamic value) async {
    if (value.runtimeType != String) throw UnimplementedError("Unsupported type for Shared Preferences");

    await secureStorage.write(key: key, value: value);
  }
}

final secureStorageDataSourceProvider = Provider<SettingsLocalDataSource>((ref) {
  return SecureStorageDataSourceImpl();
});
