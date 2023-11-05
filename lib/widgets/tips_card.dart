import 'package:flutter/material.dart';

import 'reusable_card.dart';

class TipsCard extends StatelessWidget {
  const TipsCard({
    super.key,
    required this.cardColor,
    required this.tip,
    required this.textColor,
    required this.tipBold,
  });

  final Color cardColor;
  final String tipBold;
  final String tip;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      color: cardColor,
      width: double.infinity,
      marginTop: 10,
      marginBottom: 10,
      borderRadius: 30,
      padding: 20,
      marginLeft: 0,
      marginRight: 0,
      child: RichText(
        text: TextSpan(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 13, color: textColor),
          children: <TextSpan>[
            TextSpan(
              text: tipBold,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: tip,
            ),
          ],
        ),
      ),
    );
  }
}
