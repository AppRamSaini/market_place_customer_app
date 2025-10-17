import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:market_place_customer/screens/auth/login.dart';
import 'package:market_place_customer/utils/app_router.dart';

class LocalStorage {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save data
  static Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  // Get data
  static String? getString(String key) => _preferences?.getString(key);
  static bool? getBool(String key) => _preferences?.getBool(key);
  static int? getInt(String key) => _preferences?.getInt(key);

  // Remove data
  static Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  // Clear all
  static Future<void> clearAll(BuildContext context) async {
    AppRouter().navigateAndClearStack(context, LoginScreen());
    await _preferences?.clear();
  }
}

class Pref {
  static const token = 'token';
  static const vendorId = 'vendorId';
  static const userUUID = 'user_UUID';
  static const roleType = 'role_type';
  static const userName = 'user_name';
  static const location = 'location';
}
