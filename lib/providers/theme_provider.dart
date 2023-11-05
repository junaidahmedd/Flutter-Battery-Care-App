import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeOption { system, light, dark }

class ThemeProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  ThemeModeOption _selectedMode = ThemeModeOption.system;
  String modeName = '';

  ThemeProvider() {
    _loadSelectedMode();
  }

  Future<void> _loadSelectedMode() async {
    _prefs = await SharedPreferences.getInstance();
    final modeValue = _prefs.getInt('themeMode') ?? 0;
    _selectedMode = ThemeModeOption.values[modeValue];
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    switch (_selectedMode) {
      case ThemeModeOption.system:
        modeName = 'System';
        return ThemeMode.system;
      case ThemeModeOption.light:
        modeName = 'Light';
        return ThemeMode.light;
      case ThemeModeOption.dark:
        modeName = 'Dark';
        return ThemeMode.dark;
    }
  }

  void cycleThemeMode() {
    _selectedMode = ThemeModeOption.values[(_selectedMode.index + 1) % 3];
    _prefs.setInt('themeMode', _selectedMode.index);
    notifyListeners();
  }
}
