import 'package:flutter/material.dart';

class SettingsItemCard extends StatelessWidget {
  const SettingsItemCard(
      {super.key,
      required this.icon,
      required this.itemTitle,
      required this.child,
      this.onTap,
      this.marginTop,
      this.padding});

  final double? marginTop;
  final IconData icon;
  final String itemTitle;
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        margin: const EdgeInsets.fromLTRB(
          0,
          10,
          0,
          10,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                itemTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
