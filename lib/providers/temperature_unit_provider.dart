import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemperatureUnitProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  bool _isFahrenheit = false;

  TemperatureUnitProvider() {
    _loadUnit();
  }

  Future<void> _loadUnit() async {
    _prefs = await SharedPreferences.getInstance();
    _isFahrenheit = _prefs.getBool('isFahrenheit') ?? false;
    notifyListeners();
  }

  bool isFahrenheit() {
    return _isFahrenheit;
  }

  void toggleFahrenheit() {
    _isFahrenheit = !_isFahrenheit;
    _prefs.setBool('isFahrenheit', _isFahrenheit);
    notifyListeners();
  }
}
