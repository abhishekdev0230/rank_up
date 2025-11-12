import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/models/FlashcardChapterModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

class FlashcardChapterProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isRefreshing = false;
  FlashcardChapterModel? chapterModel;

  /// Fetch chapters by subject ID
  Future<void> fetchChapters(BuildContext context, String subjectId,
      {bool isPullRefresh = false}) async {
    if (isPullRefresh) {
      isRefreshing = true;
    } else {
      isLoading = true;
    }
    notifyListeners();

    try {
      final headers = await ApiHeaders.withStoredToken();
      final String url =
      ApiUrls.flashcardsChapters.replaceFirst(':subjectId', subjectId);

      debugPrint("📘 Fetching Chapters → $url");

      final response = await ApiMethods().getMethodTwo(
        header: headers,
        method: url,
        body: {},
      );

      if (response.isNotEmpty) {
        final data = jsonDecode(response);
        chapterModel = FlashcardChapterModel.fromJson(data);

        if (chapterModel?.status == true) {
          debugPrint("✅ Chapters fetched successfully");
        } else {
          debugPrint("⚠️ ${chapterModel?.message}");
        }
      } else {
        debugPrint("⚠️ Empty response from Flashcards Chapters API");
      }
    } catch (e, st) {
      debugPrint("❌ Flashcards Chapters API Error: $e");
      debugPrint(st.toString());
    } finally {
      isLoading = false;
      isRefreshing = false;
      notifyListeners();
    }
  }


}
