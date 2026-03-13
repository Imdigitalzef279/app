import 'package:shared_preferences/shared_preferences.dart';

class DeviceAvatarStorage {
  static Future<void> saveDeviceName(
      int deviceId,
      String name,
      ) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "device_name_$deviceId",
      name,
    );
  }

  static Future<String?> getDeviceName(
      int deviceId,
      ) async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      "device_name_$deviceId",
    );
  }
  static Future<void> saveAvatar(int deviceId, String path) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "device_avatar_$deviceId",
      path,
    );
  }

  static Future<String?> getAvatar(int deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      "device_avatar_$deviceId",
    );
  }

}
