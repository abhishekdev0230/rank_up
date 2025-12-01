import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/models/subscription_model.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

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
  Future<void> activatePremium(String paymentId, String planId, Map<String, dynamic> fullPayload) async {
    try {
      final headers = await ApiHeaders.withStoredToken();

      final body = {
        "planId": planId,
        "transactionId": paymentId,
        "paymentMethod": "RAZOR",
        "rawPayload": fullPayload, // Razorpay full response
      };

      String res = await ApiMethods().postMethod(
        method: ApiUrls.activateSubscription,
        body: body,
        header: headers,
      );

      final jsonData = jsonDecode(res);
      print("⭐ Premium Activated Response: $jsonData");

      await fetchPlans();

    } catch (e) {
      print("❌ Premium activation error: $e");
    }
  }

}
