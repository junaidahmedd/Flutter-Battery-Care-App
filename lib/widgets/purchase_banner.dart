import 'package:flutter/material.dart';

class PurchaseBanner extends StatelessWidget {
  const PurchaseBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xff60ee78),
                Color(0xff4bcc63),
              ], // Gold to darker gold
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).cardTheme.shadowColor!,
                spreadRadius: 1,
                blurRadius: 22,
                offset: const Offset(-2,
                    -2), // Adjust the offset to control the shadow direction
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Text(
                  'Go Ad-Free',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                child: Text(
                  '• No Ads \n• Smooth Experience \n• 1-Time Payment',
                ),
              ),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: Text(
                    'Upgrade',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 18,
          right: 16,
          child: Image.asset(
            'assets/stars.png',
            height: 75,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
