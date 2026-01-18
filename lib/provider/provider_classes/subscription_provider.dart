import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/models/subscription_model.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionProvider extends ChangeNotifier {

  List<SubscriptionPlan> plans = [];
  UserModel? user;
  bool isLoading = false;

  /// ------- GET PLANS -------
  Future<void> fetchPlans() async {
    try {
      isLoading = true;
      notifyListeners();

      final headers = await ApiHeaders.withStoredToken();

      String res = await ApiMethods().getMethod(
        method: ApiUrls.subscriptionList,
        body: {},
        header: headers,
      );

      final jsonData = jsonDecode(res);
      final model = SubscriptionPlansResponse.fromJson(jsonData);

      if (model.status == true) {
        user = model.data!.user;
        plans = model.data!.plans ?? [];
      }

    } catch (e) {
      print("❌ Error Fetching Plans: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  /// ------- ACTIVATE PREMIUM API -------
  Future<void> activatePremium(
      String transactionId,
      String planId,
      PaymentSuccessResponse response,
      int amount,
      ) async {
    try {
      final headers = await ApiHeaders.withStoredToken();

      final body = {
        "planId": planId,
        "transactionId": transactionId,
        "paymentMethod": "RAZOR",
        "rawPayload": {
          "id": response.paymentId,
          "status": "SUCCESS",
          "paymentMethod": "RAZOR",
          "amount": amount.toString(),
        }
      };

      debugPrint("📤 Activate Premium Payload: $body");

      final res = await ApiMethods().postMethod(
        method: ApiUrls.activateSubscription,
        body: body,
        header: headers,
      );

      final jsonData = jsonDecode(res);
      debugPrint("⭐ Premium Activated Response: $jsonData");

      if (jsonData["status"] == true) {
        await fetchPlans(); // refresh user subscription
      }

    } catch (e) {
      debugPrint("❌ Premium activation error: $e");
    }
  }


}
