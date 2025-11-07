import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rank_up/models/FlashcardSubjectModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

class FlashcardProvider extends ChangeNotifier {
  bool isLoading = false; // For first screen load
  bool isTabLoading = false; // For switching between tabs
  int selectedTab = 0;

  FlashcardSubjectModel? flashcardData;

  /// Called first time when screen opens
  Future<void> init(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await flashcardsClassesGetApi(context);

    isLoading = false;
    notifyListeners();
  }

  /// When user changes tab
  Future<void> changeTab(int index, BuildContext context) async {
    selectedTab = index;
    isTabLoading = true;
    notifyListeners();

    await flashcardsClassesGetApi(context);

    isTabLoading = false;
    notifyListeners();
  }

  /// Main API call
  Future<void> flashcardsClassesGetApi(BuildContext context) async {
    try {
      final headers = await ApiHeaders.withStoredToken();

      String classCode =
      selectedTab == 0 ? "11" : selectedTab == 1 ? "12" : "13";

      final String baseUrl = ApiUrls.flashcardsClasses;
      final String url = baseUrl.replaceFirst(':classCode', classCode);

      debugPrint("📘 Flashcard API URL: $url");

      final response = await ApiMethods().getMethodTwo(
        header: headers,
        method: url,
        body: {},
      );

      if (response.isNotEmpty) {
        final data = jsonDecode(response);

        flashcardData = FlashcardSubjectModel.fromJson(data);

        if (flashcardData?.status == true) {
          debugPrint("✅ Flashcards fetched successfully for class $classCode");
        } else {
          debugPrint("⚠️ Flashcards API returned invalid status");
        }
      } else {
        debugPrint("⚠️ Empty response from Flashcards API");
      }
    } catch (e, st) {
      debugPrint("❌ Flashcards API Error: $e");
      debugPrint(st.toString());
    }
  }
}
