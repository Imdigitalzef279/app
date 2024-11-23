
import '../../../../application/enums/storages_key.dart';
import 'base_shared_preferences.dart';

class SharedPreferencesHelper extends BaseSharedPreferences {
  Future<void> setAccessToken(String accessToken) async {
    await super.setStringValue(StoragesKey.accessToken, accessToken);
  }

  Future<String> getAccessToken() async {
    return await super.getStringValue(StoragesKey.accessToken);
  }

  Future<void> removeAccessToken() async {
    await super.removeByKey(StoragesKey.accessToken);
  }
}