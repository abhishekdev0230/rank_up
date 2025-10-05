import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const isLogin = 'is_login';
  static const profileSetup = 'profile_setup';
  static const adminStatus = 'admin_status';
  static const firstName = 'first_name';
  static const nickName = 'nickNameController';
  static const accessToken = 'Token';
  static const dob = 'dob';
  static const userId = 'user_id';
  static const name = 'name';
  static const image = 'image';
  static const description = 'description';
  static const latitude = 'latitude';
  static const longitude = 'longitude';
  static const skillYouCanTeach = 'skill_you_can_teach';
  static const skillYouWantToLearn = 'skill_you_want_to_learn';
  static const address = 'address';
  static const myId = 'myId';
  static const userName = 'userName';

  /// --------------------- Save Data ------------------------
  static Future<void> savingData(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();

    if (data is String) {
      await prefs.setString(key, data);
    } else if (data is int) {
      await prefs.setInt(key, data);
    } else if (data is bool) {
      await prefs.setBool(key, data);
    } else if (data is double) {
      await prefs.setDouble(key, data);
    } else if (data is List<String>) {
      await prefs.setStringList(key, data);
    } else {
      debugPrint("❌ Invalid datatype for key: $key");
    }
  }

  /// --------------------- Read Data (dynamic) ------------------------
  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key); // yaha se correct type (bool, String, int, etc.) return hoga
  }

  /// --------------------- Typed Getters (optional) ------------------------
  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  /// --------------------- Delete Data ------------------------
  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  /// --------------------- Clear All Data ------------------------
  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
