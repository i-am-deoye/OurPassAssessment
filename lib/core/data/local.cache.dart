
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';


enum LocalCacheKeys {
  email("email"), password("password"), authenticated("authenticated");

  final String value;
  const LocalCacheKeys(this.value);
}


class LocalCache {

  static void setBool({required LocalCacheKeys key, required bool value}) async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    await prefs.setBool(key.value, value);
  }

  static void setDouble({required LocalCacheKeys key, required double value}) async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    await prefs.setDouble(key.value, value);
  }

  static void setString({required LocalCacheKeys key, required String value}) async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    await prefs.setString(key.value, value);
  }

  static void setInt({required LocalCacheKeys key, required int value}) async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    await prefs.setInt(key.value, value);
  }

  static void setStringList({required LocalCacheKeys key, required List<String> values}) async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    await prefs.setStringList(key.value, values);
  }


  static Future<String?> getString({required LocalCacheKeys key}) async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    final value = prefs.getString(key.value);
    return value;
  }

  static Future<bool?> getBool({required LocalCacheKeys key}) async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    final value = prefs.getBool(key.value);
    return value;
  }

}