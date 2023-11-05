import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.child,
    this.height,
    this.width,
    required this.marginTop,
    required this.marginBottom,
    required this.borderRadius,
    required this.padding,
    required this.marginLeft,
    required this.marginRight,
    this.color,
    this.onEnd,
  });

  final Widget child;
  final double? height;
  final double? width;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double borderRadius;
  final double padding;
  final Color? color;
  final VoidCallback? onEnd;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      onEnd: onEnd,
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.fromLTRB(
        marginLeft,
        marginTop,
        marginRight,
        marginBottom,
      ),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardTheme.surfaceTintColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).cardTheme.shadowColor!,
            spreadRadius: 1,
            blurRadius: 22,
            offset: const Offset(
              -2,
              -2,
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 200), // Animation duration
      curve: Curves.easeInOut, // Animation curve
      child: child,
    );
  }
}
