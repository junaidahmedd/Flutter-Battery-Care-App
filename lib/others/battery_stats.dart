import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import '../constants/text_styles.dart';

class BatteryHealth extends StatelessWidget {
  const BatteryHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AndroidBatteryInfo?>(
      future: BatteryInfoPlugin().androidBatteryInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.health! == 'health_good') {
            return Text(
              'Good',
              style: batteryHealthStyle,
            );
          } else if (snapshot.data!.health! == 'dead') {
            return const Text(
              'Dead',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            );
          } else if (snapshot.data!.health! == 'over_heat') {
            return const Text(
              'Over Heat',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.yellow,
              ),
            );
          } else if (snapshot.data!.health! == 'over_voltage') {
            return const Text(
              'Over Voltage',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.yellow,
              ),
            );
          } else if (snapshot.data!.health! == 'cold') {
            return const Text(
              'Cold',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            );
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
