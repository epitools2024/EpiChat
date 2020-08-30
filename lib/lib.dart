import 'package:shared_preferences/shared_preferences.dart';

Future<void> resetCounter(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt(key, value);
}

Future<int> getIntFromSharedPref(String intkey) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getInt(intkey);

  if (value == null) {
    return 0;
  }
  return value;
}

Future<String> getStringFromSharedPref(String stringKey) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString(stringKey);

  if (value == null) {
    return null;
  }
  return value;
}

Future<bool> getBoolFromSharedPref(String boolKey) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getBool(boolKey);

  if (value == null) {
    return null;
  }
  return value;
}

Future<void> setIntValue(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt(key, value);
}

Future<void> setStringValue(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(key, value);
}

Future<void> setBoolValue(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setBool(key, value);
}
