import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../providers/alarm_provider.dart';
import '../reusable_card.dart';
import '../sliders/full_battery_slider.dart';

class FullBatteryAlarmCard extends StatelessWidget {
  const FullBatteryAlarmCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmProvider>(
      builder: (context, provider, _) {
        bool fullSwitchValue = provider.fullSwitchValue;
        bool off = provider.fullOff;
        return ReusableCard(
          onEnd: () {
            provider.fullBatterySetOff(false);
          },
          height: fullSwitchValue ? 192 : 100,
          marginTop: 20,
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
                          'Full Battery Alarm',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Set an alarm for overcharging.',
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: fullSwitchValue,
                    onChanged: (v) async {
                      var status = await Permission.notification.status;
                      if (status.isGranted) {
                        provider.fullBatterySetOff(true);
                        provider.toggleFullSwitchValue(v);
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
                  visible: fullSwitchValue,
                  child: const FullSlider(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
