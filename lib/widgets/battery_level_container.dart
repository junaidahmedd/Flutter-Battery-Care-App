import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BatteryLevelContainer extends StatefulWidget {
  final double fillPercentage;

  const BatteryLevelContainer({super.key, required this.fillPercentage});

  @override
  BatteryLevelContainerState createState() => BatteryLevelContainerState();
}

class BatteryLevelContainerState extends State<BatteryLevelContainer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: SizedBox(
        height: 310,
        width: double.infinity,
        child: WaveWidget(
          config: CustomConfig(
            gradients: [
              [
                const Color(0xff60ee78),
                const Color(0xff7FFF95),
              ],
              [
                const Color(0xff60ee78),
                const Color(0xff6AFC84),
              ],
            ],
            durations: [5000, 7000],
            heightPercentages: [
              widget.fillPercentage / 100,
              widget.fillPercentage / 100
            ],
            blur: const MaskFilter.blur(BlurStyle.solid, 10),
          ),
          backgroundColor: Colors.transparent,
          size: const Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}
