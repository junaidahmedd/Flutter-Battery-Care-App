import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:batterycare/providers/alarm_provider.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool fullAlarm;
late bool lowAlarm;

bool lowBatteryNotificationShown = false;

late int fullSelectedPercentage;
late int lowSelectedPercentage;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'foreground', // id
    'BATTERY ALERT', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      notificationChannelId: 'foreground',
      initialNotificationTitle: 'BatteryCare is running',
      initialNotificationContent: 'Taking care of your battery...',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  fullAlarm = prefs.getBool('isFullAlarmOn') ?? false;
  lowAlarm = prefs.getBool('isLowAlarmOn') ?? false;
  fullSelectedPercentage = prefs.getInt('fullSelectedPercentage') ?? 80;
  lowSelectedPercentage = prefs.getInt('lowSelectedPercentage') ?? 20;

  service.on('updateFullAlarm').listen((event) {
    fullAlarm = event!["bool"];
  });

  service.on('updateLowAlarm').listen((event) {
    lowAlarm = event!["bool"];
  });

  service.on('updateFullPercentage').listen((event) {
    fullSelectedPercentage = event!["max"];
  });

  service.on('updateLowPercentage').listen((event) {
    lowSelectedPercentage = event!["min"];
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 1), (timer) async {
    checkBatteryLevelAndNotify();
  });

  return true;
}

void showFullBatteryNotification() {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin.show(
    999,
    'Battery charged above $fullSelectedPercentage!',
    'Disconnect your charger to stop Alarm.',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'battery_alert',
        'Battery Alert',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
  );
}

void showLowBatteryNotification() {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin.show(
    999,
    'Battery level below $lowSelectedPercentage!',
    'Don\'t compromise and connect your charger.',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'battery_alert',
        'Battery Alert',
        importance: Importance.high,
      ),
    ),
  );
}

Future<void> playAudio() async {
  AudioPlayer player = AudioPlayer();
  await player.play(AssetSource('sounds/alarm.mp3'));
}

void checkBatteryLevelAndNotify() async {
  final Battery battery = Battery();
  final batteryLevel = await battery.batteryLevel;
  final batteryState = await battery.batteryState;

  if (fullAlarm &&
      batteryState == BatteryState.charging &&
      batteryLevel >= fullSelectedPercentage) {
    showFullBatteryNotification();
    playAudio();
  } else if (lowAlarm &&
      batteryState == BatteryState.discharging &&
      batteryLevel <= lowSelectedPercentage) {
    if (!lowBatteryNotificationShown) {
      lowBatteryNotificationShown = true;
      showLowBatteryNotification();
      playAudio();
    }
  }
  if (lowBatteryNotificationShown && batteryLevel > lowSelectedPercentage) {
    lowBatteryNotificationShown = false;
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  fullAlarm = prefs.getBool('isFullAlarmOn') ?? false;
  lowAlarm = prefs.getBool('isLowAlarmOn') ?? false;
  fullSelectedPercentage = prefs.getInt('fullSelectedPercentage') ?? 80;
  lowSelectedPercentage = prefs.getInt('lowSelectedPercentage') ?? 20;

  service.on('updateFullAlarm').listen((event) {
    fullAlarm = event!["bool"];
  });

  service.on('updateLowAlarm').listen((event) {
    lowAlarm = event!["bool"];
  });

  service.on('updateFullPercentage').listen((event) {
    fullSelectedPercentage = event!["max"];
  });

  service.on('updateLowPercentage').listen((event) {
    lowSelectedPercentage = event!["min"];
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 1), (timer) async {
    checkBatteryLevelAndNotify();
  });
}

void startBackgroundTask(AlarmProvider provider) {
  if (provider.fullSwitchValue || provider.lowSwitchValue) {
    FlutterBackgroundService().startService();
  } else {
    FlutterBackgroundService().invoke('stopService');
  }
}
