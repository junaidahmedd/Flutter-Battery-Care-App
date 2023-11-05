import 'package:batterycare/constants/app_colors.dart';
import 'package:batterycare/providers/analytics_provider.dart';
import 'package:batterycare/views/alarm_page.dart';
import 'package:batterycare/views/home_page.dart';
import 'package:batterycare/views/settings_page.dart';
import 'package:batterycare/views/tips_page.dart';
import 'package:batterycare/widgets/banner_ad.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:batterycare/others/ads_manager.dart';

import 'subscription_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: _titleList.length, vsync: this);

  AdsManager adsManager = AdsManager();

  bool bannerLoaded = false;

  static const List<String> _titleList = [
    'Battery Info',
    'Alarm',
    'Tips',
    'Settings'
  ];

  @override
  void initState() {
    adsManager.loadAd();
    super.initState();
  }

  @override
  void dispose() {
    adsManager.disposeInterstitialAd();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final analyticsProvider =
        Provider.of<AnalyticsProvider>(context, listen: false);

    void launchAppRating() async {
      Uri url = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.batterycare.app');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    void shareApp() {
      final box = context.findRenderObject() as RenderBox?;
      const String text =
          'Check out this amazing Battery app! Download it from the link: https://play.google.com/store/apps/details?id=com.batterycare.app';
      Share.share(text,
          subject: 'Download the App',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleSpacing: 20,
        elevation: 0.0,
        title: Text(
          _titleList[_tabController.index],
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/crown.png',
              height: 24,
              width: 24,
            ),
            onPressed: () {
              analyticsProvider.logScreen("Subscription Page");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubscriptionPage(),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (choice) {
              if (choice == 'rateApp') {
                launchAppRating();
              } else if (choice == 'shareApp') {
                shareApp();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'rateApp',
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      SizedBox(width: 8),
                      Text('Rate App'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'shareApp',
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Share App'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          HomePage(),
          AlarmPage(),
          TipsPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: GNav(
                  hoverColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor!,
                  haptic: false,
                  gap: 8,
                  activeColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor!,
                  color: AppColors.unselectedIconColor,
                  tabs: const [
                    GButton(
                      icon: FluentIcons.home_24_filled,
                      text: 'Home',
                    ),
                    GButton(
                      icon: FluentIcons.clock_alarm_24_filled,
                      text: 'Alarm',
                    ),
                    GButton(
                      icon: FluentIcons.lightbulb_24_filled,
                      text: 'Tips',
                    ),
                    GButton(
                      icon: FluentIcons.settings_24_filled,
                      text: 'Settings',
                    ),
                  ],
                  selectedIndex: _tabController.index,
                  onTabChange: (index) {
                    setState(() {
                      _tabController.index = index;
                      adsManager.showInterstitialAd(context);
                      analyticsProvider.logScreen(_titleList[index]);
                    });
                  },
                ),
              ),
              const BannerAdWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
