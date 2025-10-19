import 'package:flutter/material.dart';


extension LangExtension on BuildContext {
  Languages get lang => Languages.of(this)!;
}


abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;
  String get skip;
  String get next;
  String get signIn;

  String get onboardingTitle1;
  String get onboardingTitle11;
  String get onboardingDesc1;

  String get onboardingTitle2;
  String get onboardingTitle22;
  String get onboardingDesc2;

  String get onboardingTitle3;
  String get onboardingTitle33;
  String get onboardingDesc3;

  String get onboardingTitle4;
  String get onboardingTitle44;
  String get onboardingDesc4;

  String get subjectPractice;
  String get welcomeRankUp;
  String get buildKnowledge;
  String get signInWithGoogle;
  String get signInWithApple;
  String get signInWithGithub;
  String get termsAndConditions;
  String get privacyPolicy;
  String get bySigningUpText;
  String get signInWithMobileNumber;
  String get verifyAccountWithOTP;
  String get weHaveSentAnOtpCode;
  String get helloThere;
  String get pleaseEnterYour;
  String get letsBuildYour;
  String get phoneNumber;
  String get rememberMe;
  String get orContinueWith;

  String get enterOtp;
  String get otpSentMessage;
  String get didntReceiveCode;
  String get resendCodeIn;
  String get verify;

  String get completeProfileTitle;
  String get completeProfileSubtitle;
  String get fullNameLabel;
  String get fullNameHint;
  String get emailLabel;
  String get emailHint;
  String get phoneNumberLabel;
  String get phoneNumberHint;
  String get classLabel;
  String get classHint;
  String get stateLabel;
  String get stateHint;
  String get cityLabel;
  String get cityHint;
  String get continueButton;
}
