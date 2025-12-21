import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nara/core/helpers/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedprefHelper {
  static late SharedPreferences sharedPref;
  static Future<void> cacheInitialization() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(String key, String value) async {
    return await sharedPref.setString(key, value);
  }

  static String? getData(String key) {
    return sharedPref.getString(key) ?? "";
  }

  static Future<bool> deleteData({required String key}) async {
    return await sharedPref.remove(key);
  }

  static Future<bool> setBoolData(String key, bool value) async {
    return await sharedPref.setBool(key, value);
  }

  static bool? getBoolData(String key) {
    return sharedPref.getBool(key) ?? false;
  }

  static Future<void> setSecurityString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('Storing key: $key with value: $value');
    await flutterSecureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecurityString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    return await flutterSecureStorage.read(key: key);
  }

  static Future<void> clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.delete(key: StorageConstants.savedToken);
  }
}
