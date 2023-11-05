import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PurchaseProvider extends ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  Set<String> productIds = {'ad_free_lifetime'};
  bool _isAvailable = false;
  List<ProductDetails> _products = [];
  bool _loading = true;
  bool _adsRemoved = false;
  bool _isRestore = false;

  bool get isAvailable => _isAvailable;
  List<ProductDetails> get products => _products;
  bool get isLoading => _loading;
  bool get adsRemoved => _adsRemoved;
  bool get isRestore => _isRestore;

  PurchaseProvider() {
    initialize();
    _loadAdsRemoved();
  }

  // Initialize In-App Purchase
  Future<void> initialize() async {
    _isAvailable = await _inAppPurchase.isAvailable();
    if (_isAvailable) {
      await _loadProducts();
      _listenToPurchaseStream();
    } else {
      Fluttertoast.showToast(
        msg: "Service not available!",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    _loading = false;
    notifyListeners();
  }

  void _listenToPurchaseStream() {
    _inAppPurchase.purchaseStream
        .listen((List<PurchaseDetails> purchaseDetailsList) {
      _handlePurchases(purchaseDetailsList);
    });
  }

  void _handlePurchases(List<PurchaseDetails> purchaseDetailsList) {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.productID == "ad_free_lifetime") {
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          setAdsRemoved(true);
          Fluttertoast.showToast(
            msg: "Purchase successful!",
            toastLength: Toast.LENGTH_SHORT,
          );
        } else if (purchaseDetails.status == PurchaseStatus.restored) {
          setAdsRemoved(true);
          Fluttertoast.showToast(
            msg: "Purchase Restored!",
            toastLength: Toast.LENGTH_SHORT,
          );
        } else if (purchaseDetails.status == PurchaseStatus.pending) {
          Fluttertoast.showToast(
            msg: "Payment Pending!",
            toastLength: Toast.LENGTH_SHORT,
          );
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          setAdsRemoved(false);
          Fluttertoast.showToast(
            msg: "Purchase Canceled!",
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          setAdsRemoved(false);
          Fluttertoast.showToast(
            msg: "Action failed!",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
        break;
      } else {
        setAdsRemoved(false);
        Fluttertoast.showToast(
          msg: "Please make a purchase first!",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }
  }

  Future<void> _loadProducts() async {
    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(productIds);
    if (productDetailResponse.error != null) {
      return;
    }
    _products = productDetailResponse.productDetails;
  }

  Future<void> purchaseProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    try {
      await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
    } catch (e) {
      // Handle purchase error
      if (kDebugMode) {
        print('purchaseProduct: $e');
      }
    }
  }

  Future<void> restorePurchase() async {
    _isRestore = true;
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      // Handle restore error
      if (kDebugMode) {
        print('restorePurchase: $e');
      }
    }
  }

  Future<void> setAdsRemoved(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('adsRemoved', value);
    _adsRemoved = prefs.getBool('adsRemoved') ?? false;
    notifyListeners();
  }

  Future<void> _loadAdsRemoved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _adsRemoved = prefs.getBool('adsRemoved') ?? false;
    notifyListeners();
  }
}
