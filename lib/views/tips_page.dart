import 'package:batterycare/constants/app_colors.dart';
import 'package:batterycare/widgets/tips_card.dart';
import 'package:flutter/material.dart';

import '../constants/battery_tips.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Dos:',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const TipsCard(
              cardColor: AppColors.tipsCardColorGreen,
              tip: tip1,
              textColor: Colors.black,
              tipBold: tip1Bold,
            ),
            const TipsCard(
              cardColor: AppColors.tipsCardColorGreen,
              tip: tip2,
              textColor: Colors.black,
              tipBold: tip2Bold,
            ),
            const TipsCard(
              cardColor: AppColors.tipsCardColorGreen,
              tip: tip3,
              textColor: Colors.black,
              tipBold: tip3Bold,
            ),
            const TipsCard(
              cardColor: AppColors.tipsCardColorGreen,
              tip: tip4,
              textColor: Colors.black,
              tipBold: tip4Bold,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Don\'ts:',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const TipsCard(
              cardColor: AppColors.tipsCardColorRed,
              tip: tip5,
              textColor: Colors.white,
              tipBold: tip5Bold,
            ),
            const TipsCard(
              cardColor: AppColors.tipsCardColorRed,
              tip: tip6,
              textColor: Colors.white,
              tipBold: tip6Bold,
            ),
            const TipsCard(
              cardColor: AppColors.tipsCardColorRed,
              tip: tip7,
              textColor: Colors.white,
              tipBold: tip7Bold,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}
