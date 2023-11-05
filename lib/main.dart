import 'package:batterycare/firebase_options.dart';
import 'package:batterycare/others/app_review_popup.dart';
import 'package:batterycare/providers/analytics_provider.dart';
import 'package:batterycare/providers/purchase_provider.dart';
import 'package:batterycare/providers/temperature_unit_provider.dart';
import 'package:batterycare/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'providers/alarm_provider.dart';
import 'providers/theme_provider.dart';
import 'constants/themes.dart';
import 'service/background_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await initializeService();
  AppReviewPopup().setTime();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AlarmProvider()),
        ChangeNotifierProvider(create: (context) => TemperatureUnitProvider()),
        ChangeNotifierProvider(create: (context) => PurchaseProvider()),
        ChangeNotifierProvider(create: (context) => AnalyticsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Battery Care',
          themeMode: themeProvider.getThemeMode(),
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          home: const Home(),
        );
      },
    );
  }
}
