abstract class SettingRepository {
  Future<void> clearSetting();
  Future<void> clearSecureSetting();
  dynamic loadSetting(String key);
  Future<String?> loadSecureSetting(String key);
  Future<void> updateSetting(String key, dynamic value);
  Future<void> updateSecureSetting(String key, String value);
}
