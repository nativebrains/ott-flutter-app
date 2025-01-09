import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../../features/account/models/LoginUserModel.dart';

class SharedPrefs {
  static const int _cacheDurationInHours = 24;
  static const int _cacheDuration =
      _cacheDurationInHours * 60 * 60 * 1000; // Convert hours to milliseconds
  // static SharedPreferences _prefs;
  static late final SharedPreferences _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  //sets
  static Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  //gets
  static bool? getBool(String key) => _prefs.getBool(key);

  static double? getDouble(String key) => _prefs.getDouble(key);

  static int? getInt(String key) => _prefs.getInt(key);

  static String? getString(String key) => _prefs.getString(key);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  //deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();

  static Future<String?> getCachedData(String key) async {
    final String? cachedDataString = _prefs.getString(key);
    if (cachedDataString != null) {
      final Map<String, dynamic> cachedData = json.decode(cachedDataString);
      final int? timestamp = cachedData['timestamp_$key'];
      final int? cacheDuration = cachedData['cacheDuration_$key'];
      if (timestamp != null &&
          cacheDuration != null &&
          DateTime.now().millisecondsSinceEpoch - timestamp < cacheDuration) {
        // Cache is still valid
        return cachedData['data_$key'];
      }
    }
    return null; // Cache expired or not present
  }

  static Future<void> cacheData(String data, String key,
      {int cacheDuration = _cacheDuration}) async {
    final Map<String, dynamic> cachedData = {
      'data_$key': data,
      'timestamp_$key': DateTime.now().millisecondsSinceEpoch,
      'cacheDuration_$key': cacheDuration,
    };
    await _prefs.setString(key, json.encode(cachedData));
  }

  static Future<void> clearCache(String key) async {
    await _prefs.remove(key);
  }

  static storeLoginUserData(LoginUserModel userProfileModel) async {
    await _prefs.setString(
        Constants.userDataKey, json.encode(userProfileModel.toJson()));
  }

  static clearLoginUserData() async {
    await _prefs.remove(Constants.userDataKey);
  }

  static LoginUserModel? getLoginUserData() {
    final jsonString = _prefs.getString(Constants.userDataKey);
    if (jsonString == null) {
      return null; // No stored profile
    }
    final jsonMap = json.decode(jsonString); // Convert the JSON string to a Map
    return LoginUserModel.fromJson(jsonMap);
  }
}
