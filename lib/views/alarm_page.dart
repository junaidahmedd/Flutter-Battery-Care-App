import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../widgets/alarmCards/full_battery_alarm_card.dart';
import '../widgets/alarmCards/low_battery_alarm_card.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FullBatteryAlarmCard(),
          const LowBatteryAlarmCard(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  const Icon(
                    FluentIcons.warning_16_filled,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'Keep your phone volume high for the alarm to ring.',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 13,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
