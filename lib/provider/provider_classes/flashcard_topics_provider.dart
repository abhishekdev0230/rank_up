import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/models/FlashcardTopicsModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

class FlashcardTopicsProvider extends ChangeNotifier {
  bool isLoading = false;
  FlashcardTopicsModel? topicsModel;

  Future<void> fetchTopics(BuildContext context, String chapterId) async {
    isLoading = true;
    notifyListeners();

    try {
      final headers = await ApiHeaders.withStoredToken();
      final String url = ApiUrls.flashcardsTopics.replaceFirst(':chapterId', chapterId);

      debugPrint("📘 Fetching Topics → $url");

      final response = await ApiMethods().getMethodTwo(
        header: headers,
        method: url,
        body: {},
      );

      if (response.isNotEmpty) {
        final data = jsonDecode(response);
        topicsModel = FlashcardTopicsModel.fromJson(data);
        debugPrint("✅ Topics fetched: ${topicsModel?.data?.length}");
      } else {
        debugPrint("⚠️ Empty response from Flashcards Topics API");
      }
    } catch (e, st) {
      debugPrint("❌ Flashcards Topics API Error: $e");
      debugPrint(st.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
