import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundCubit extends Cubit<String?> {
  BackgroundCubit() : super(null);

  static const _key = "app_bg";

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    emit(prefs.getString(_key));
  }

  Future<void> setBg(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, path);
    emit(path); // 🔥 đổi ngay lập tức
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    emit(null);
  }
}