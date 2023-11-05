import 'package:batterycare/providers/purchase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/round_icon_button.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    var purchase = Provider.of<PurchaseProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RoundIconButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/premium.webp',
                      height: 250,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Ad-Free Experience',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'No Ads \nSmooth Experience \n1-Time Payment',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            height: 1.7,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Text(
                      purchase.products.isNotEmpty
                          ? '${purchase.products[0].price} - Lifetime'
                          : 'Loading...',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!purchase.adsRemoved) {
                          purchase.purchaseProduct(purchase.products.first);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: purchase.adsRemoved == false
                            ? const Color(0xff50fb82)
                            : Theme.of(context).iconTheme.color!.withAlpha(30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Container(
                        width: 250,
                        padding: const EdgeInsets.all(14),
                        alignment: Alignment.center,
                        child: Text(
                          purchase.adsRemoved == false
                              ? 'Purchase'
                              : 'Purchased',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: purchase.adsRemoved == false
                                        ? Colors.black
                                        : Theme.of(context).iconTheme.color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        purchase.restorePurchase();
                      },
                      child: Text(
                        'Restore Purchase',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
