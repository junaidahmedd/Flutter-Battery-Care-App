import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../providers/alarm_provider.dart';
import '../reusable_card.dart';
import '../sliders/low_battery_slider.dart';

class LowBatteryAlarmCard extends StatelessWidget {
  const LowBatteryAlarmCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmProvider>(
      builder: (context, provider, _) {
        bool lowSwitchValue = provider.lowSwitchValue;
        bool off = provider.lowOff;

        return ReusableCard(
          onEnd: () {
            provider.lowBatterySetOff(false);
          },
          height: lowSwitchValue ? 192 : 100,
          marginTop: 15,
          marginBottom: 5,
          borderRadius: 30,
          padding: 25,
          marginLeft: 15,
          marginRight: 15,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.notifications_active_rounded,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Low Battery Alarm',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Set an alarm for low battery.',
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: lowSwitchValue,
                    onChanged: (v) async {
                      var status = await Permission.notification.status;
                      if (status.isGranted) {
                        provider.lowBatterySetOff(true);
                        await provider.toggleLowSwitchValue(v);
                      } else {
                        await Permission.notification.request();
                      }
                    },
                  ),
                ],
              ),
              Offstage(
                offstage: off,
                child: Visibility(
                  visible: lowSwitchValue,
                  child: const LowSlider(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
