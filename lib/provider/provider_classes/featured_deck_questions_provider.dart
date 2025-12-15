import 'package:flutter/material.dart';
import 'package:rank_up/models/FeatureDeckQuestionsModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

class FeaturedDeckQuestionsProvider extends ChangeNotifier {
  List<FeatureDatum> questions = [];

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;

  int page = 1;
  final int limit = 20;

  String deckId = "";

  void init(String id) {
    deckId = id;
    reset();
    fetchQuestions();
  }

  void reset() {
    questions = [];
    page = 1;
    hasMore = true;
    isLoading = false;
    isLoadingMore = false;
  }

  // Fetch API
  Future<void> fetchQuestions() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    final url = ApiUrls.baseUrl +
        "feature-decks/$deckId/questions?page=$page&limit=$limit";

    final response = await ApiMethods().getMethod(
      method: url,
      body: {},
      header: await ApiHeaders.withStoredToken(),
    );

    final parsed = featureDeckQuestionsModelFromJson(response);

    if (parsed.data != null && parsed.data!.isNotEmpty) {
      questions.addAll(parsed.data!);

      if (parsed.data!.length < limit) {
        hasMore = false;
      }
    } else {
      hasMore = false;
    }

    isLoading = false;
    notifyListeners();
  }

  // Load next page
  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;
    page++;
    notifyListeners();

    final url = ApiUrls.baseUrl +
        "feature-decks/$deckId/questions?page=$page&limit=$limit";

    final response = await ApiMethods().getMethod(
      method: url,
      body: {},
      header: await ApiHeaders.withStoredToken(),
    );

    final parsed = featureDeckQuestionsModelFromJson(response);

    if (parsed.data != null && parsed.data!.isNotEmpty) {
      questions.addAll(parsed.data!);

      if (parsed.data!.length < limit) {
        hasMore = false;
      }
    } else {
      hasMore = false;
    }

    isLoadingMore = false;
    notifyListeners();
  }
}
