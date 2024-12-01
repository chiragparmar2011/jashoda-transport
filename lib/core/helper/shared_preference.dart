import 'dart:convert';

import 'package:jashoda_transport/data/model/user/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper({required this.preferences});

  SharedPreferences preferences;

  String accessToken = 'accessToken';
  String refreshToken = 'refreshToken';
  String userInfo = 'userInfo';
  String fcmToken = 'fcmToken';
  String languageKey = 'languageKey';

  SharedPreferences? getPrefs() {
    return preferences;
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> setAccessToken(String? token) async {
    if (token != null) {
      await preferences.setString(accessToken, token);
    }
  }

  Future<void> setFcmToken(String? token) async {
    if (token != null) {
      await preferences.setString(fcmToken, token);
    }
  }

  Future<void> setRefreshToken(String? token) async {
    if (token != null) {
      await preferences.setString(refreshToken, token);
    }
  }

  String getAccessToken() {
    return getString(accessToken);
  }

  Future<bool> saveDataInSharedPreference({required String key, required dynamic value}) async {
    if (value is bool) {
      return await preferences.setBool(key, value);
    } else if (value is String) {
      return await preferences.setString(key, value);
    } else if (value is int) {
      return await preferences.setInt(key, value);
    } else {
      return await preferences.setDouble(key, value);
    }
  }

  bool getBool(String key) {
    final value = preferences.getBool(key);
    if (value == null) {
      return false;
    }
    return value;
  }

  double getDouble(String key) {
    final value = preferences.getDouble(key);
    if (value == null) {
      return 0;
    }
    return value;
  }

  int getInt(String key) {
    final value = preferences.getInt(key);
    if (value == null) {
      return 0;
    }
    return value;
  }

  getString(String key) {
    final value = preferences.getString(key);
    if (value == null) {
      return;
    }
    return value;
  }

  Future<void> setString({required String key, required String value}) async {
    await preferences.setString(key, value);
  }

  void setUser(UserModel? userModel) {
    if (userModel != null) {
      preferences.setString(userInfo, jsonEncode(userModel));
    }
  }

  UserModel? getUser() {
    final value = preferences.getString(userInfo);
    if (value == null) {
      return null;
    }
    return UserModel.fromJson(jsonDecode(value));
  }

  Future remove(String key) async => await preferences.remove(key);

  Future clear() async => await preferences.clear();

  Future<void> logout() async {
    remove(accessToken);
  }
}