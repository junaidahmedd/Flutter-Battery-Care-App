import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../providers/alarm_provider.dart';

class LowSlider extends StatelessWidget {
  const LowSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmProvider>(
      builder: (context, provider, _) {
        double lowBattery = provider.lowSelectedPercentage.toDouble();

        return Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            RichText(
              text: TextSpan(
                text: 'Your alarm will ring at ',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14,
                    ),
                children: [
                  TextSpan(
                    text: '${lowBattery.toInt()}%',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                  ),
                ],
              ),
            ),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 4.0,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 20.0),
                activeTrackColor: AppColors.sliderActiveColor,
                inactiveTrackColor:
                    AppColors.sliderActiveColor.withOpacity(0.3),
                thumbColor: AppColors.sliderActiveColor,
              ),
              child: Slider(
                value: lowBattery,
                divisions: 6,
                min: 10,
                max: 40,
                onChanged: (double v) {
                  provider.updateLowSelectedPercentage(v.toInt());
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
