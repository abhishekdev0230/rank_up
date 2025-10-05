import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider_classes/OnboardingProvider.dart';

class AppProviders {
  static MultiProvider init({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      child: child,
    );
  }
}
