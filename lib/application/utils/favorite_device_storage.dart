import 'package:shared_preferences/shared_preferences.dart';

class FavoriteDeviceStorage {

  static const _key = "favorite_devices";

  static Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final list = prefs.getStringList(_key) ?? [];

    return list.map((e) => int.parse(e)).toList();
  }

  static Future<void> saveFavorites(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      _key,
      ids.map((e) => e.toString()).toList(),
    );
  }
}