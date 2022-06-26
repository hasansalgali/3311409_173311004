import 'package:shared_preferences/shared_preferences.dart';
//import 'package:extended_shared_preferences/MethodChannel.dart';
//import 'package:extended_shared_preferences/SharedPreferences.dart';

class StorageManager {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

class Str2 {
  static void saveData(String key, dynamic value) async {
    final ins = await SharedPreferences.getInstance();
    if (value is int) {
      ins.setInt(key, value);
    } else if (value is String) {
      ins.setString(key, value);
    } else if (value is bool) {
      ins.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  static Future<dynamic> readData(String key) async {
    final ins = await SharedPreferences.getInstance();
    dynamic obj = ins.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final ins = await SharedPreferences.getInstance();
    return ins.remove(key);
  }
}
