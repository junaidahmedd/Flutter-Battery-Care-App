import 'package:batterycare/providers/analytics_provider.dart';
import 'package:batterycare/providers/temperature_unit_provider.dart';
import 'package:batterycare/views/subscription_page.dart';
import 'package:batterycare/widgets/settings_card.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/theme_provider.dart';
import '../widgets/purchase_banner.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final temperatureUnit = Provider.of<TemperatureUnitProvider>(context);
    final analyticsProvider =
        Provider.of<AnalyticsProvider>(context, listen: false);

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: PurchaseBanner(
                onTap: () {
                  analyticsProvider.logScreen("Subscription Page");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubscriptionPage(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Text(
                'General',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 15,
                    ),
              ),
            ),
            SettingsItemCard(
              onTap: () {
                themeProvider.cycleThemeMode();
              },
              icon: FluentIcons.paint_brush_24_regular,
              itemTitle: 'Theme',
              child: Text(
                themeProvider.modeName,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13,
                    ),
              ),
            ),
            SettingsItemCard(
              onTap: () {
                temperatureUnit.toggleFahrenheit();
              },
              marginTop: 10,
              icon: FluentIcons.temperature_24_regular,
              itemTitle: 'Temperature Unit',
              child: Text(
                temperatureUnit.isFahrenheit() ? '°F' : '°C',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 15,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 5),
              child: Text(
                'Others',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 15,
                    ),
              ),
            ),
            SettingsItemCard(
              onTap: () async {
                Uri url = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.batterycare.app');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              icon: FluentIcons.star_24_regular,
              itemTitle: 'Rate Us',
              child: Text(
                '',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13,
                    ),
              ),
            ),
            SettingsItemCard(
              onTap: () async {
                Uri url = Uri.parse(
                    'https://play.google.com/store/apps/dev?id=6370181125641710941');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              icon: FluentIcons.apps_24_regular,
              itemTitle: 'More Apps',
              child: Text(
                '',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
