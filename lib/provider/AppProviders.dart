import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/provider/provider_classes/HomeProvider.dart';
import 'package:rank_up/provider/provider_classes/ProfileSetupProvider.dart';
import 'provider_classes/OnboardingProvider.dart';

class AppProviders {
  static MultiProvider init({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => ProfileSetupProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: child,
    );
  }
}
