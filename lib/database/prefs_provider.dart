import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsProvider {
  static late final SharedPreferences _prefs;

  static Future<SharedPreferences> load() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<void> saveToken(String token) async {
    await _prefs.setString('token', jsonEncode(token));
    // Logger().i('Mmøtkim: Token: $token Saved');
  }

  static Future<void> saveRefreshToken(String token) async {
    await _prefs.setString('refresh_token', jsonEncode(token));
    // Logger().i('Mmøtkim: Token: $token Saved');
  }

  static Future<void> saveTokens(String token, String refreshtoken) async {
    await _prefs.setString('token', jsonEncode(token));
    await _prefs.setString('refresh_token', jsonEncode(token));
  }

  static Future<String?> getToken() async {
    final encodedToken = await _prefs.getString('token')!;
    // Logger().i('Mmøtkim: getToken: ${jsonDecode(encodedToken)}');
    return jsonDecode(encodedToken);
  }

  static Future<String?> getRefreshToken() async {
    final encodedToken = await _prefs.getString('refresh_token');
    // Logger().i('Mmøtkim: getToken: ${jsonEncode(encodedToken)}');
    return jsonEncode(encodedToken);
  }

  static Future<Locale?> getLocale() async {
    final locale = await _prefs.getString('locale');
    if (locale != null) {
      final string = locale.split('_');
      if (string[1] != null) {
        return Locale(string[0], string[1]);
      } else {
        return Locale(string[0]);
      }
    } else {
      return null;
    }
  }
}
