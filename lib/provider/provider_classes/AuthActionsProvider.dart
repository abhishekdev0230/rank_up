import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/services/api_key_word.dart';
import 'package:rank_up/services/local_storage.dart';
import 'package:rank_up/Utils/helper.dart';

class AuthActionsProvider extends ChangeNotifier {

  /// ---------------------- LOGOUT ----------------------
  Future<bool> logout(BuildContext context) async {
    CommonLoaderApi.show(context);

    final headers = await ApiHeaders.withStoredToken();

    final response = await ApiMethods().postMethodCM(
      method: ApiUrls.logout,
      body: {},
      header: headers,
    );

    CommonLoaderApi.hide(context);

    if (response != null && response.status == true) {
      Helper.customToast("Logged out successfully");

      await StorageManager.clearData();
      return true;
    } else {
      Helper.customToast(response?.message ?? "Logout failed");
      return false;
    }
  }

  /// ---------------------- DELETE ACCOUNT ----------------------
  Future<bool> deleteAccount(BuildContext context, {String reason = "Deleting, no reason specific"}) async {
    CommonLoaderApi.show(context);

    final headers = await ApiHeaders.withStoredToken();

    final response = await ApiMethods().deleteMethod(
      method: ApiUrls.deleteAccount,
      body: {
        "reason": reason,
      },
      header: headers,
    );

    CommonLoaderApi.hide(context);

    final decoded = jsonDecode(response);

    if (decoded["status"] == true) {
      Helper.customToast("Account deleted successfully");
      await StorageManager.clearData();
      return true;
    } else {
      Helper.customToast(decoded["message"] ?? "Delete account failed");
      return false;
    }
  }

  /// ---------------------- RESET ACCOUNT ----------------------
  Future<bool> resetAccount(BuildContext context) async {
    CommonLoaderApi.show(context);

    final headers = await ApiHeaders.withStoredToken();

    final response = await ApiMethods().postMethodCM(
      method: ApiUrls.resetAccount,
      body: {},
      header: headers,
    );

    CommonLoaderApi.hide(context);

    if (response != null && response.status == true) {
      Helper.customToast("Account reset successfully");
      return true;
    } else {
      Helper.customToast(response?.message ?? "Reset failed");
      return false;
    }
  }
}
