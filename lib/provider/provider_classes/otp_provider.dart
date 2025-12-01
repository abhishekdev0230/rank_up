import 'package:flutter/material.dart';
import 'package:rank_up/main.dart';
import 'package:rank_up/services/api_key_word.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/services/local_storage.dart';

class OtpProvider extends ChangeNotifier {
  bool isLoading = false;
  String otpCode = '';

  /// ✅ SEND OTP API
  Future<bool> sendOtp({
    required BuildContext context,
    required String phoneNumber,
    required String countryCode,
  }) async {
    if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      // 🔹 Show message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit phone number'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }


    isLoading = true;
    notifyListeners();

    final res = await ApiHelper.callPostApi(
      context: context,
      endpoint: ApiUrls.sendOtp,
      body: {
        ApiKeyWord.phoneNumber: phoneNumber,
        ApiKeyWord.countryCode: countryCode
      },
    );

    isLoading = false;
    notifyListeners();

    if (res?.status == true) {
      return true;
    } else {
      return false;
    }
  }

  /// ✅ VERIFY OTP API + Save Access Token
  Future<Map<String, dynamic>?> verifyOtp({
    required BuildContext context,
    required String phoneNumber,
    required String rememberMe,
  }) async {
    if (otpCode.isEmpty) return null;

    isLoading = true;
    notifyListeners();

    final res = await ApiHelper.callPostApi(
      context: context,
      endpoint: ApiUrls.verifyOtp,
      body: {
        ApiKeyWord.phoneNumber: phoneNumber,
        ApiKeyWord.otp: otpCode,
        ApiKeyWord.rememberMe: rememberMe,
        ApiKeyWord.deviceId: deviceId ?? "ewdewww",
        ApiKeyWord.deviceType: deviceType ?? "android",
        ApiKeyWord.fcmToken: fcmToken ?? "djksjkksdjksjkds",
      },
    );

    isLoading = false;
    notifyListeners();

    if (res?.status == true) {
      // Save Token
      if (res?.accessToken != null && res!.accessToken!.isNotEmpty) {
        await StorageManager.savingData(
          StorageManager.accessToken,
          res.accessToken!,
        );
        debugPrint("✅ Access Token Saved: ${res.accessToken}");
      }

      // 👉 RETURN FULL DATA HERE
      return {
        "success": true,
        "isNewUser": res?.isNewUser ?? false,
        "data": res?.data,
      };
    }

    return {"success": false};
  }



  void setOtp(String value) {
    otpCode = value;
    notifyListeners();
  }
}
