import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/provider/provider_classes/FlashcardCompletionProvider.dart';
import 'package:rank_up/provider/provider_classes/FlashcardsQuestionsProvider.dart';
import 'package:rank_up/provider/provider_classes/HomeProvider.dart';
import 'package:rank_up/provider/provider_classes/ProfileSetupProvider.dart';
import 'package:rank_up/provider/provider_classes/flashcard_chapter_provider.dart';
import 'package:rank_up/provider/provider_classes/flashcard_provider.dart';
import 'package:rank_up/provider/provider_classes/flashcard_topics_provider.dart';
import 'package:rank_up/provider/provider_classes/otp_provider.dart';
import 'provider_classes/BookmarkedCardsProvider.dart';
import 'provider_classes/OnboardingProvider.dart';

class AppProviders {
  static MultiProvider init({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => ProfileSetupProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => FlashcardProvider()),
        ChangeNotifierProvider(create: (_) => FlashcardChapterProvider()),
        ChangeNotifierProvider(create: (_) => FlashcardTopicsProvider()),
        ChangeNotifierProvider(create: (_) => FlashcardsQuestionsProvider()),
        ChangeNotifierProvider(create: (_) => FlashcardCompletionProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkedCardsProvider()),
      ],
      child: child,
    );
  }
}
