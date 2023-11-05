import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/background_service.dart';

class AlarmProvider extends ChangeNotifier {
  bool _fullSwitchValue = false;
  bool _lowSwitchValue = false;
  bool _fullBatteryOffSet = false;
  bool _lowBatteryOffSet = false;
  int _lowSelectedPercentage = 20;
  int _fullSelectedPercentage = 80;

  bool get fullSwitchValue => _fullSwitchValue;
  bool get lowSwitchValue => _lowSwitchValue;
  bool get fullOff => _fullBatteryOffSet;
  bool get lowOff => _lowBatteryOffSet;
  int get lowSelectedPercentage => _lowSelectedPercentage;
  int get fullSelectedPercentage => _fullSelectedPercentage;

  Future<void> toggleFullSwitchValue(bool value) async {
    _fullSwitchValue = value;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFullAlarmOn', value);

    FlutterBackgroundService().invoke('updateFullAlarm', {
      'bool': value,
    });
    startBackgroundTask(this);
  }

  Future<void> toggleLowSwitchValue(bool value) async {
    _lowSwitchValue = value;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLowAlarmOn', value);

    FlutterBackgroundService().invoke('updateLowAlarm', {
      'bool': value,
    });
    startBackgroundTask(this);
  }

  void fullBatterySetOff(bool value) {
    _fullBatteryOffSet = value;
    notifyListeners();
  }

  void lowBatterySetOff(bool value) {
    _lowBatteryOffSet = value;
    notifyListeners();
  }

  Future<void> updateLowSelectedPercentage(int value) async {
    _lowSelectedPercentage = value;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lowSelectedPercentage', value);

    FlutterBackgroundService().invoke('updateLowPercentage', {
      'min': value,
    });
  }

  Future<void> updateFullSelectedPercentage(int value) async {
    _fullSelectedPercentage = value;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fullSelectedPercentage', value);

    FlutterBackgroundService().invoke('updateFullPercentage', {
      'max': value,
    });
  }

  AlarmProvider() {
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = await Permission.notification.status;
    if (status.isGranted) {
      _fullSwitchValue = prefs.getBool('isFullAlarmOn') ?? false;
      _fullBatteryOffSet = _fullSwitchValue;

      _lowSwitchValue = prefs.getBool('isLowAlarmOn') ?? false;
      _lowBatteryOffSet = _lowSwitchValue;
    } else {
      _fullSwitchValue = false;
      _fullBatteryOffSet = _fullSwitchValue;
      _lowSwitchValue = false;
      _lowBatteryOffSet = _lowSwitchValue;
    }
    _fullSelectedPercentage = prefs.getInt('fullSelectedPercentage') ?? 80;
    _lowSelectedPercentage = prefs.getInt('lowSelectedPercentage') ?? 20;

    notifyListeners();
    startBackgroundTask(this);
  }
}
