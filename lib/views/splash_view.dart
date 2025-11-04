import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/services/local_storage.dart';
import 'package:rank_up/views/bottom_navigation_bar.dart';
import 'package:rank_up/views/onboarding_screen/onboarding_screen.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // splash delay

    final bool? isLogin = await StorageManager.getBool(StorageManager.isLogin);

    if (isLogin == true) {
      // ✅ User already logged in → Go to Home
      CustomNavigator.pushRemoveUntil(
        context,
        BottomNavController(initialIndex: 0),
      );
    } else {
      // 🚀 New user → Go to Onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appTheme,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              IconsPath.splashBg,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: SvgPicture.asset(
              IconsPath.appLogoWhite,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
