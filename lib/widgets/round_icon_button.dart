import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RoundIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.0,
      right: 20.0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          width: 38.0,
          height: 38.0,
          decoration: BoxDecoration(
            color: Theme.of(context).iconTheme.color!.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.close,
              color: Theme.of(context).iconTheme.color,
              size: 22.0,
            ),
          ),
        ),
      ),
    );
  }
}
