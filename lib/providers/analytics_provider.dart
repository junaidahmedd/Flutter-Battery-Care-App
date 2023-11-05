import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';

class AnalyticsProvider extends ChangeNotifier {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  void logScreen(String screenName) {
    _analytics.logScreenView(
      screenName: screenName,
    );
  }
}
