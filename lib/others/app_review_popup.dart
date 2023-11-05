import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppReviewPopup {
  final InAppReview _inAppReview = InAppReview.instance;
  late DateTime _firstOpenDateTime;

  void setTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool firstOpen = pref.getBool('firstOpen') ?? false;
    if (!firstOpen) {
      _firstOpenDateTime = DateTime.now();
      pref.setString('firstOpenDate', _firstOpenDateTime.toString());
      pref.setBool('firstOpen', true);
    } else {
      getTime();
    }
  }

  void getTime() async {
    String dateTimeString;
    SharedPreferences pref = await SharedPreferences.getInstance();
    dateTimeString = pref.getString('firstOpenDate')!;
    _firstOpenDateTime = DateTime.parse(dateTimeString);
    if (DateTime.now().difference(_firstOpenDateTime).inDays > 2) {
      Future.delayed(const Duration(seconds: 2), () {
        _requestReview();
      });
    }
  }

  Future<void> _requestReview() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool hidePopup = pref.getBool('hidePopup') ?? false;
    if (!hidePopup) {
      _inAppReview.requestReview();
      pref.setBool('hidePopup', true);
    }
  }
}
