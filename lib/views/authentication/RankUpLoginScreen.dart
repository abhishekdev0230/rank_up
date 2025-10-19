import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/Utils/languages.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';

import 'LoginOptionContainer.dart';
import 'PhoneNumberContainer.dart';
import 'OtpVerificationContainer.dart';
import 'ProfileSetupContainer.dart';

class RankUpLoginScreen extends StatefulWidget {
  const RankUpLoginScreen({super.key});

  @override
  State<RankUpLoginScreen> createState() => _RankUpLoginScreenState();
}

class _RankUpLoginScreenState extends State<RankUpLoginScreen> {
  bool showOtpContainer = false;
  bool showOtpVerifyContainer = false;
  bool showProfileSetup = false;

  String phoneNumber = '';
  String countryCode = '+91';

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;

    return Scaffold(
      backgroundColor: MyColors.appTheme,
      body: SafeArea(
        child: Stack(
          children: [
            // ----------------- SCROLLABLE TOP CONTENT -----------------
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: context.hp(0.45)),
              child: Column(
                children: [
                  SizedBox(height: context.hp(0.05)),
                  Center(
                    child: SvgPicture.asset(
                      IconsPath.appLogoWhite,
                      height: 135,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    lang.subjectPractice,
                    style: mediumTextStyle(
                      fontSize: context.hp(0.018),
                      color: MyColors.whiteText.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: context.hp(0.20)),
                  if (!showOtpContainer &&
                      !showOtpVerifyContainer &&
                      !showProfileSetup) ...[
                    Center(
                      child: Text(
                        lang.welcomeRankUp,
                        textAlign: TextAlign.center,
                        style: semiBoldTextStyle(
                          fontSize: 28,
                          color: MyColors.whiteText,
                        ),
                      ),
                    ),
                    hSized8,
                    Center(
                      child: Text(
                        lang.letsBuildYour,
                        textAlign: TextAlign.center,
                        style: mediumTextStyle(
                          fontSize: 18,
                          color: MyColors.whiteText,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ----------------- FIXED BOTTOM CONTAINER -----------------
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: showProfileSetup
                    ? ProfileSetupContainer(lang: lang)
                    : showOtpVerifyContainer
                    ? OtpVerificationContainer(
                  lang: lang,
                  phoneNumber: phoneNumber,
                  countryCode: countryCode,
                  onOtpVerified: () {
                    setState(() {
                      showOtpVerifyContainer = false;
                      showProfileSetup = true;
                    });
                  },
                )
                    : showOtpContainer
                    ? PhoneNumberContainer(
                  lang: lang,
                  onSignInTap: (phone, code) {
                    setState(() {
                      phoneNumber = phone;
                      countryCode = code;
                      showOtpVerifyContainer = true;
                    });
                  },
                )
                    : LoginOptionContainer(
                  lang: lang,
                  onMobileLoginTap: () {
                    setState(() {
                      showOtpContainer = true;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
