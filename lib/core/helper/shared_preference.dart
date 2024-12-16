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

  Future<void> setAccessToken(String? token) async {
    if (token != null) {
      await preferences.setString(accessToken, token);
    }
  }

  bool getBool(String key) {
    final value = preferences.getBool(key);
    if (value == null) {
      return false;
    }
    return value;
  }

  Future<void> setBool({required String key, required bool value}) async {
    await preferences.setBool(key, value);
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
}