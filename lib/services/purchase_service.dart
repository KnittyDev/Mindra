import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'dart:io' show Platform;

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  final String _apiKey = 'test_CUVZTNQzCCTxYBrktMvfMuXfrGu';
  final String _entitlementId = 'Rivora Pro'; // Matches RevenueCat Identifier

  bool _isPro = false;
  bool get isPro => _isPro;

  Future<void> init() async {
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration = PurchasesConfiguration(_apiKey);
    await Purchases.configure(configuration);

    await updateCustomerStatus();
  }

  Future<void> updateCustomerStatus() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      _isPro = customerInfo.entitlements.all[_entitlementId]?.isActive ?? false;
    } on PlatformException catch (e) {
      // Error fetching customer info
      print('Error fetching customer info: $e');
      _isPro = false;
    }
  }

  Future<void> showPaywall() async {
    try {
      // Present the Paywall
      // This uses RevenueCat's native UI
      final paywallResult = await RevenueCatUI.presentPaywallIfNeeded(_entitlementId);

      // After paywall closes, check status again
      await updateCustomerStatus();

    } on PlatformException catch (e) {
       print('Error showing paywall: $e');
    }
  }

  Future<void> showCustomerCenter() async {
    try {
       await RevenueCatUI.presentCustomerCenter();
    } on PlatformException catch (e) {
       print('Error showing customer center: $e');
    }
  }

  Future<void> restorePurchases() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      _isPro = customerInfo.entitlements.all[_entitlementId]?.isActive ?? false;
    } on PlatformException catch (e) {
      print('Error restoring purchases: $e');
    }
  }
  
  // Method to manually purchase a package (if building custom UI)
  Future<bool> purchasePackage(Package package) async {
    try {
      CustomerInfo customerInfo = await Purchases.purchasePackage(package);
      _isPro = customerInfo.entitlements.all[_entitlementId]?.isActive ?? false;
      return _isPro;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        print('Purchase error: $e');
      }
      return false;
    }
  }
}
