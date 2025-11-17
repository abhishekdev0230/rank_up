import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/FlashcardsQuestionsModel.dart';
import 'package:rank_up/services/api_key_word.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

class FlashcardsQuestionsProvider extends ChangeNotifier {
  FlashcardsQuestionsModel? flashcardModel;
  Flashcard? currentCard;
  int currentIndex = 0;
  int currentPage = 1;
  bool hasNextPage = false;
  Set<String> bookmarkedIds = {};
  bool isBookmarked(String id) {
    return bookmarkedIds.contains(id);
  }

  // ------------------ FETCH INITIAL + PAGINATED DATA ------------------
  Future<void> fetchTopics(
      BuildContext context,
      String topicId, {
        int page = 1,
      }) async {
    CommonLoaderApi.show(context);

    final headers = await ApiHeaders.withStoredToken();
    final String url =
        "${ApiUrls.flashcardsTopicsQuetions.replaceFirst(':topicId', topicId)}?page=$page";

    final response = await ApiMethods().getMethodTwo(
      header: headers,
      method: url,
      body: {},
    );

    CommonLoaderApi.hide(context);

    final decoded = json.decode(response);
    final model = FlashcardsQuestionsModel.fromJson(decoded);

    // --------------------------------------------------
    // ✅ FIX: No data → clear the old card
    // --------------------------------------------------
    if (model.data == null ||
        model.data!.flashcards == null ||
        model.data!.flashcards!.isEmpty) {
      flashcardModel = null;
      currentCard = null;
      notifyListeners();
      return;
    }

    // --------------------------------------------------
    // Normal data handling
    // --------------------------------------------------
    if (page == 1) {
      flashcardModel = model;
    } else {
      flashcardModel!.data!.flashcards!.addAll(
        model.data!.flashcards ?? [],
      );
    }

    currentCard = flashcardModel!.data!.flashcards!.first;
    currentIndex = 0;

    currentPage = model.data!.pagination?.currentPage ?? 1;
    hasNextPage = model.data!.pagination?.hasNextPage ?? false;

    notifyListeners();
  }


  // ------------------ NEXT + PREV LOGIC ------------------
  Future<void> nextCard(BuildContext context, String topicId) async {
    final totalCards = flashcardModel?.data?.flashcards?.length ?? 0;

    if (currentIndex < totalCards - 1) {
      currentIndex++;
      currentCard = flashcardModel!.data!.flashcards![currentIndex];
      notifyListeners();
    } else if (hasNextPage) {
      currentPage++;
      await fetchTopics(context, topicId, page: currentPage);
    } else {
      // no more pages → handled by screen
    }
  }

  void prevCard() {
    if (currentIndex > 0) {
      currentIndex--;
      currentCard = flashcardModel!.data!.flashcards![currentIndex];
      notifyListeners();
    }
  }

  Future<void> flashcardsTopicsQuetionsprogress({
    required BuildContext context,
    required int confidenceLevel,
    required String flashcardId,
  }) async {
    try {
      CommonLoaderApi.show(context);

      final headers = await ApiHeaders.withStoredToken();
      final String url = ApiUrls.flashcardsTopicsQuetionsprogress.replaceFirst(
        ':flashcardId',
        flashcardId,
      );

      final response = await ApiMethods().postMethodCM(
        header: headers,
        method: url,
        body: {ApiKeyWord.confidenceLevel: confidenceLevel},
      );

      CommonLoaderApi.hide(context);

      if (response != null && response.status == true) {
        // ✅ Update confidence locally in model
        if (currentCard != null && currentCard!.id.toString() == flashcardId) {
          currentCard = currentCard!.copyWith(confidence: confidenceLevel);
        }

        // ✅ Also update the same card inside the main list (for consistency)
        final allCards = flashcardModel?.data?.flashcards;
        if (allCards != null && allCards.isNotEmpty) {
          final index = allCards.indexWhere(
            (c) => c.id.toString() == flashcardId,
          );
          if (index != -1) {
            allCards[index] = allCards[index].copyWith(
              confidence: confidenceLevel,
            );
          }
        }

        notifyListeners();

        // ✅ Toast success message using Helper
        Helper.customToast(
          response.message ?? "Progress updated successfully 🎯",
        );
      } else {
        Helper.customToast(response?.message ?? "Failed to update progress.");
      }
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Error updating progress: $e");
    }
  }

  ///..............bookmark............
  Future<void> bookmarkAdd({
    required BuildContext context,
    required String contentId,
  }) async {
    CommonLoaderApi.show(context);

    final headers = await ApiHeaders.withStoredToken();
    final String url = ApiUrls.bookmarks;

    final response = await ApiMethods().postMethodCM(
      header: headers,
      method: url,
      body: {
        ApiKeyWord.contentId: contentId.toString(),
        ApiKeyWord.contentType: "FLASHCARD",
      },
    );

    CommonLoaderApi.hide(context);

    if (response != null && response.status == true) {
      // ✅ Toggle locally
      if (bookmarkedIds.contains(contentId)) {
        bookmarkedIds.remove(contentId);
        Helper.customToast("Removed from bookmarks");
      } else {
        bookmarkedIds.add(contentId);
        Helper.customToast("Added to bookmarks");
      }
      notifyListeners();
    } else {
      Helper.customToast(response?.message ?? "Failed to update bookmark");
    }
  }

}
