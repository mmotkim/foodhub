// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrefsProvider {
  static late final SharedPreferences _prefs;
  static late final FlutterSecureStorage _storage;

  static const String _token = 'token';
  static const String _refreshToken = 'refresh_token';
  static const String _userId = 'user_id';

  static Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );  
    _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  static Future<void> saveCustom(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static Future<void> printCustom(String key) async {
    debugPrint(_prefs.getString(key));
  }

  static Future<String?> getCustom(String key) async {
    return _prefs.getString(key);
  }

  static Future<void> saveToken(String token) async {
    // await _prefs.setString('token', jsonEncode(token));
    await _storage.write(key: _token, value: token);
    Logger().i('Mmøtkim: Token: $token Saved');
  }

  static Future<void> saveRefreshToken(String token) async {
    // await _prefs.setString('refresh_token', jsonEncode(token));
    await _storage.write(key: _refreshToken, value: token);
    Logger().i('Mmøtkim: Refresh Token: $token Saved');
  }

  static Future<void> saveTokens(String token, String refreshtoken) async {
    // await _prefs.setString('token', jsonEncode(token));
    // await _prefs.setString('refresh_token', jsonEncode(token));
    await _storage.write(key: _token, value: token);
    await _storage.write(key: _refreshToken, value: refreshtoken);
  }

  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userId, value: userId);
  }

  static Future<String?> getToken() async {
    // final encodedToken = await _prefs.getString('token')!;
    // Logger().i('Mmøtkim: getToken: ${jsonDecode(encodedToken)}');
    // return jsonDecode(encodedToken);
    final token = await _storage.read(key: _token);
    return token;
  }

  static Future<String?> getRefreshToken() async {
    // final encodedToken = await _prefs.getString('refresh_token');
    // Logger().i('Mmøtkim: getToken: ${jsonEncode(encodedToken)}');
    // return jsonEncode(encodedToken);
    final refreshToken = await _storage.read(key: _refreshToken);
    return refreshToken;
  }

  static Future<String?> getUserId() async {
    final userId = await _storage.read(key: _userId);
    Logger().d(userId);
    return userId;
  }

  static Future<void> deleteAll() async {
    _storage.deleteAll();
  }

  static Future<Locale?> getLocale() async {
    final locale = _prefs.getString('locale');
    if (locale != null) {
      final string = locale.split('_');
      if (string[1].isEmpty) {
        return Locale(string[0], string[1]);
      } else {
        return Locale(string[0]);
      }
    } else {
      return null;
    }
  }
}
