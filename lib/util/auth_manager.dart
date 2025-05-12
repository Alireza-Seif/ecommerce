import 'package:ecommerce/di/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static const String _tokenKey = 'access_token';
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    await _sharedPref.setString(_tokenKey, token);
    authChangeNotifier.value = token;
  }
 
  static String readAuth() {
    return _sharedPref.getString(_tokenKey) ?? '';
  }

  static void logout() {
    _sharedPref.clear();
    authChangeNotifier.value = null;
  }

  static bool isLogin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
