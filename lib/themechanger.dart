import 'package:flutter/material.dart';
import 'storage_manager.dart';

class ThemeChanger with ChangeNotifier {
  ThemeMode? themeMode;
  ThemeMode? getTheme() => themeMode;

  int? maxLength;
  int? getMaxLength() => maxLength;

  ThemeChanger() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        this.themeMode = ThemeMode.light;
      } else if (themeMode == 'dark') {
        print('setting dark theme');
        this.themeMode = ThemeMode.dark;
      } else {
        this.themeMode = ThemeMode.light;
      }
      notifyListeners();
    });

    Str2.readData('maxLength').then((val) {
      print('value read from storage: ' + val);
      var max = val;
      if (max != null) {
        this.maxLength = max;
      } else {
        this.maxLength = 250;
      }
      notifyListeners();
    });
  }

  void setMaxLength(int max) {
    this.maxLength = max;
    notifyListeners();
    Str2.saveData('maxLength', this.maxLength);
  }

  int? read2() {
    Str2.readData('maxLength').then((val) {
      return val;
    });
  }

  void setDarkMode() {
    this.themeMode = ThemeMode.dark;
    notifyListeners();
    StorageManager.saveData('themeMode', 'dark');
  }

  void setLightMode() async {
    this.themeMode = ThemeMode.light;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
