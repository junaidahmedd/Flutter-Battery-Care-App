import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:batterycare/others/battery_stats.dart';
import 'package:batterycare/constants/app_colors.dart';
import 'package:batterycare/providers/temperature_unit_provider.dart';
import 'package:batterycare/widgets/battery_level_container.dart';
import 'package:batterycare/widgets/reusable_card.dart';
import 'package:batterycare/widgets/small_card.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/battery_level_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final temperatureUnit = Provider.of<TemperatureUnitProvider>(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ReusableCard(
              height: 180,
              width: double.infinity,
              borderRadius: 30,
              padding: 20,
              marginTop: 20,
              marginBottom: 5,
              marginLeft: 20,
              marginRight: 20,
              child: Stack(
                children: [
                  Text('Battery Health',
                      style: Theme.of(context).textTheme.bodySmall),
                  const Center(
                    child: BatteryHealth(),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      FluentIcons.heart_32_regular,
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<AndroidBatteryInfo?>(
              stream: BatteryInfoPlugin().androidBatteryInfoStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ReusableCard(
                              height: 295,
                              marginLeft: 20,
                              marginRight: 7.5,
                              marginTop: 10,
                              marginBottom: 5,
                              borderRadius: 30,
                              padding: 0,
                              child: Stack(
                                children: [
                                  BatteryLevelContainer(
                                    fillPercentage: 100 -
                                        snapshot.data!.batteryLevel!.toDouble(),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20.0),
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Text(
                                          'Battery Level',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontSize: 12,
                                              ),
                                        ),
                                        Center(
                                          child: BatteryLevelText(
                                              batteryLevel:
                                                  snapshot.data!.batteryLevel!),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SmallCard(
                                  marginRight: 20,
                                  marginLeft: 7.5,
                                  cardWidth: double.infinity,
                                  cardTitle: 'Status',
                                  titleStyle:
                                      Theme.of(context).textTheme.bodySmall!,
                                  detail:
                                      '${(snapshot.data?.chargingStatus.toString().split(".")[1])}',
                                  detailStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                  icon: FluentIcons.battery_charge_24_regular,
                                  iconColor: AppColors.primaryColor,
                                ),
                                SmallCard(
                                  marginRight: 20,
                                  marginLeft: 7,
                                  cardWidth: double.infinity,
                                  cardTitle: 'Temperature',
                                  titleStyle:
                                      Theme.of(context).textTheme.bodySmall!,
                                  detail: temperatureUnit.isFahrenheit()
                                      ? '${(snapshot.data!.temperature! * 1.8 + 32).toStringAsFixed(2)} °F'
                                      : '${snapshot.data!.temperature!} °C',
                                  detailStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                  icon: FluentIcons.temperature_24_regular,
                                  iconColor: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SmallCard(
                              marginRight: 7.5,
                              marginLeft: 15,
                              cardTitle: 'Voltage',
                              titleStyle:
                                  Theme.of(context).textTheme.bodySmall!,
                              detail: '${(snapshot.data?.voltage)} mV',
                              detailStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                              icon: FluentIcons.flash_24_regular,
                            ),
                          ),
                          Expanded(
                            child: SmallCard(
                              marginRight: 15,
                              marginLeft: 7.5,
                              cardTitle: 'Energy Left',
                              titleStyle:
                                  Theme.of(context).textTheme.bodySmall!,
                              detail:
                                  '${(-snapshot.data!.remainingEnergy! * 1.0E-9).toStringAsFixed(2)} Wh',
                              detailStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                              icon: FluentIcons.battery_warning_24_regular,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SmallCard(
                              marginRight: 7.5,
                              marginLeft: 15,
                              cardTitle: 'Scale',
                              titleStyle:
                                  Theme.of(context).textTheme.bodySmall!,
                              detail: '${(snapshot.data?.scale)}',
                              detailStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                              icon: FluentIcons.battery_10_24_regular,
                            ),
                          ),
                          Expanded(
                            child: SmallCard(
                              marginRight: 15,
                              marginLeft: 7.5,
                              cardColor: const Color(0xff60ee78),
                              cardTitle: 'Battery Type',
                              titleStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                              detail: '${(snapshot.data?.technology)}',
                              detailStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                              icon: FluentIcons.battery_checkmark_24_regular,
                              iconColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SmallCard(
                        marginRight: 15,
                        marginLeft: 15,
                        marginBottom: 25,
                        cardWidth: double.infinity,
                        cardTitle: 'Charge time until full',
                        titleStyle: Theme.of(context).textTheme.bodySmall!,
                        detail: _getChargeTime(snapshot.data!),
                        detailStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                        icon: FluentIcons.clock_24_regular,
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getChargeTime(AndroidBatteryInfo data) {
    if (data.chargingStatus == ChargingStatus.Charging) {
      return data.chargeTimeRemaining == -1
          ? "Calculating remaining charge time..."
          : "Charge time remaining: ${(data.chargeTimeRemaining! / 1000 / 60).truncate()} minutes";
    }
    return "Battery is full or not connected to a power source";
  }
}
