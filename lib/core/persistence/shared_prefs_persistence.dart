import 'dart:convert';

import 'package:breathe_app/core/persistence/persistence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsPersistence implements Persistence {
  const SharedPrefsPersistence(this._prefs);

  final SharedPreferences _prefs;

  @override
  bool? readBool(String key) => _prefs.getBool(key);

  @override
  int? readInt(String key) => _prefs.getInt(key);

  @override
  Map<String, dynamic>? readJson(String key) {
    final jsonValue = _prefs.getString(key);
    if (jsonValue == null) {
      return null;
    }

    final decoded = jsonDecode(jsonValue);
    return decoded is Map<String, dynamic> ? decoded : null;
  }

  @override
  String? readString(String key) => _prefs.getString(key);

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> writeBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<void> writeInt(String key, int value) => _prefs.setInt(key, value);

  @override
  Future<void> writeJson(String key, Map<String, dynamic> value) {
    return _prefs.setString(key, jsonEncode(value));
  }

  @override
  Future<void> writeString(String key, String value) {
    return _prefs.setString(key, value);
  }
}
