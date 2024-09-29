import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'setting_local_data_source.dart';

class SharedPrefDataSourceImpl implements SettingLocalDataSource {
  SharedPrefDataSourceImpl();

  late SharedPreferences prefs;

  @override
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> clearSetting() async {
    await prefs.clear();
  }

  @override
  dynamic loadSetting(String key) {
    return prefs.get(key);
  }

  @override
  Future<void> updateSetting(String key, dynamic value) async {
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else {
      throw UnimplementedError('Unsupported type for Shared Preferences');
    }
  }
}

final sharedPreferencesDataSourceProvider = Provider<SettingLocalDataSource>((ref) {
  return SharedPrefDataSourceImpl();
});
