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
}
