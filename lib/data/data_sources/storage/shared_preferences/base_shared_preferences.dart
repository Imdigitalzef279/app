import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../application/enums/storages_key.dart';

abstract class BaseSharedPreferences {
  Future<void> setStringValue(StoragesKey key, String value) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      preferences.setString(key.name, value);
    } catch (e, s) {
      debugPrint("SAVE STRING $key ERROR: $e $s");
    }
  }

  Future<String> getStringValue(StoragesKey key) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final value = preferences.getString(key.name) ?? '';
      return value;
    } catch (e, s) {
      debugPrint("GET STRING $key ERROR: $e $s");
      return "";
    }
  }

  Future<void> setIntValue(StoragesKey key, int value) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      preferences.setInt(key.name, value);
    } catch (e, s) {
      debugPrint("SAVE INT $key ERROR: $e $s");
    }
  }

  Future<int?> getIntValue(StoragesKey key) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final value = preferences.getInt(key.name);
      return value;
    } catch (e, s) {
      debugPrint("GET INT $key ERROR: $e $s");
      return null;
    }
  }

  Future<void> removeByKey(StoragesKey key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(key.name);
    } catch (e, s) {
      debugPrint("REMOVE $key ERROR: $e $s");
    }
  }
}
