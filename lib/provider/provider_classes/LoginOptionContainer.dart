import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/services/local_storage.dart';
import 'package:rank_up/main.dart';

class AuthProvider extends ChangeNotifier {
  GoogleSignInAccount? currentUser;
  bool isInitialized = false;

  AuthProvider() {
    initGoogle();
  }

  /// ---------------------------------------------------------
  /// INIT GOOGLE SIGN-IN (NEW v7.2.0 SYSTEM)
  /// ---------------------------------------------------------
  Future<void> initGoogle() async {
    final signIn = GoogleSignIn.instance;

    await signIn.initialize();

    signIn.authenticationEvents.listen(
          (event) => _handleEvent(event),
      onError: (err) => debugPrint("Auth Error: $err"),
    );

    signIn.attemptLightweightAuthentication();

    isInitialized = true;
    notifyListeners();
  }


  /// ---------------------------------------------------------
  /// HANDLE GOOGLE AUTH EVENTS
  /// ---------------------------------------------------------
  void _handleEvent(GoogleSignInAuthenticationEvent event) async {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        currentUser = event.user;
        break;

      case GoogleSignInAuthenticationEventSignOut():
        currentUser = null;
        break;
    }

    notifyListeners();
  }

  /// ---------------------------------------------------------
  /// LOGIN (authenticate → get idToken → Firebase → backend)
  /// ---------------------------------------------------------
  Future<Map<String, dynamic>?> login(BuildContext context) async {
    try {
      debugPrint("==============================================");
      debugPrint("🔵 GOOGLE LOGIN STARTED");
      debugPrint("==============================================");

      // Step 1 → Authenticate UI Open
      await GoogleSignIn.instance.authenticate();
      debugPrint("✔ Step 1: Google Authentication UI Opened");

      if (currentUser == null) {
        debugPrint("❌ ERROR: Google user is NULL after authentication");
        return null;
      }

      // Step 2 → Get IdToken (NEW API)
      final GoogleSignInAuthentication auth =
      await currentUser!.authentication;

      final idToken = auth.idToken;
      if (idToken == null) {
        debugPrint("❌ ERROR: Google ID Token is NULL");
        return null;
      }

      debugPrint("✔ Step 2: ID Token Fetched${currentUser!.email}");
      debugPrint("🟦 ID Token (Short) → ${idToken.substring(0, 25)}...");

      // Step 3 → Firebase Sign In
      debugPrint("🔄 Signing in with Firebase...");
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint("✔ Step 3: Firebase login successful");

      // Step 4 → Your backend login
      final requestBody = {
        "email": currentUser!.email,
        "device_id": deviceId ?? "",
        "device_type": deviceType ?? "android",
        "fcm_token": fcmToken ?? "",
      };

      debugPrint("==============================================");
      debugPrint("⬇️ BACKEND GOOGLE LOGIN REQUEST ⬇️");
      debugPrint("URL → ${ApiUrls.googleLogin}");
      debugPrint("Headers → {Content-Type: application/json}");
      debugPrint("Request Body → ${requestBody.toString()}");
      debugPrint("==============================================");

      final response = await ApiHelper.callPostApi(
        context: context,
        endpoint: ApiUrls.googleLogin,
        body: requestBody,
      );

      debugPrint("⬆️ BACKEND RESPONSE RECEIVED ⬆️");
      debugPrint("Status → ${response?.status}");
      debugPrint("Full Response → ${response.toString()}");

      if (response?.status == true) {
        await StorageManager.savingData(
          StorageManager.accessToken,
          response!.accessToken!,
        );

        debugPrint("==============================================");
        debugPrint("🟢 LOGIN SUCCESS");
        debugPrint("New User → ${response.isNewUser}");
        debugPrint("==============================================");

        return {
          "success": true,
          "isNewUser": response.isNewUser ?? false,
          "data": response.data,
        };
      }

      debugPrint("🔴 BACKEND LOGIN FAILED");

      return {"success": false};
    } catch (e) {
      debugPrint("🔥 Google Login Error: $e");
      return null;
    }
  }


  /// ---------------------------------------------------------
  /// LOGOUT
  /// ---------------------------------------------------------
  Future<void> logout() async {
    await GoogleSignIn.instance.disconnect();
    await FirebaseAuth.instance.signOut();
    currentUser = null;
    notifyListeners();
  }
}
