abstract class SettingsLocalDataSource {
  dynamic init();
  Future<void> clearSetting();
  dynamic loadSetting(String key);
  Future<void> updateSetting(String key, dynamic value);
}
