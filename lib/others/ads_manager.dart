import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../constants/admob_ad_id.dart';
import '../providers/purchase_provider.dart';

class AdsManager {
  final interstitialId =
      Platform.isAndroid ? androidInterstitialID : iosInterstitialID;

  InterstitialAd? _interstitialAd;
  int _interstitialAdCount = 0;

  void loadAd() {
    InterstitialAd.load(
        adUnitId: interstitialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void showInterstitialAd(BuildContext context) {
    var purchase = Provider.of<PurchaseProvider>(context, listen: false);
    if (_interstitialAd != null && purchase.adsRemoved == false) {
      _interstitialAdCount++;
      if (_interstitialAdCount % 2 != 0) {
        _interstitialAd?.show();
        loadAd();
      }
    } else {
      debugPrint('Interstitial ad is not loaded yet.');
    }
  }

  void disposeInterstitialAd() {
    _interstitialAd?.dispose();
  }
}
