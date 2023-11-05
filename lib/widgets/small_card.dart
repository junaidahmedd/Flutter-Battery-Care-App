import 'package:batterycare/widgets/reusable_card.dart';
import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  const SmallCard({
    super.key,
    this.cardColor,
    required this.cardTitle,
    required this.titleStyle,
    required this.detail,
    required this.detailStyle,
    required this.icon,
    this.iconColor,
    this.cardWidth,
    required this.marginLeft,
    required this.marginRight,
    this.marginBottom,
  });

  final double? cardWidth;
  final Color? cardColor;
  final String cardTitle;
  final TextStyle titleStyle;
  final String detail;
  final TextStyle detailStyle;
  final IconData icon;
  final Color? iconColor;
  final double marginLeft;
  final double marginRight;
  final double? marginBottom;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      color: cardColor,
      width: cardWidth,
      height: 140,
      marginLeft: marginLeft,
      marginRight: marginRight,
      marginTop: 10,
      marginBottom: marginBottom ?? 5,
      borderRadius: 30,
      padding: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardTitle,
                style: titleStyle,
              ),
              Text(
                detail,
                style: detailStyle,
              ),
            ],
          ),
          Icon(
            icon,
            color: iconColor,
            size: 32,
          ),
        ],
      ),
    );
  }
}
