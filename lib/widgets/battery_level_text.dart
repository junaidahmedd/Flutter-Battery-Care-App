import 'package:flutter/material.dart';

class BatteryLevelText extends StatelessWidget {
  final int batteryLevel;

  const BatteryLevelText({super.key, required this.batteryLevel});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$batteryLevel',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 42),
          ),
          TextSpan(
            text: '%',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
