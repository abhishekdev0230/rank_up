import 'package:flutter/material.dart';
import 'package:rank_up/models/ReviewAnswerModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';

class ReviewProvider extends ChangeNotifier {
  bool isLoading = false;
  ReviewAnswerModel? reviewModel;
  String currentFilter = "all";

  Future<void> fetchReview({
    required BuildContext context,
    required String attemptId,
    String filter = "all",
  }) async {
    isLoading = true;
    currentFilter = filter;
    notifyListeners();

    final headers = await ApiHeaders.withStoredToken();

    final res = await ApiMethods().postMethod(
      method: ApiUrls.attemptReview,
      body: {
        "attemptId": attemptId,
        "filter": filter.toLowerCase()
      },
      header: headers,
    );

    if (res.isEmpty) {
      isLoading = false;
      notifyListeners();
      return;
    }

    reviewModel = reviewAnswerModelFromJson(res);
    isLoading = false;
    notifyListeners();
  }
  Future<void> toggleBookmark({
    required BuildContext context,
    required String attemptId,
    required String questionId,
    required bool isBookmarked,
    required int index,
  }) async {
    // UI update first (optimistic)
    reviewModel?.data?[index].isBookmarked = isBookmarked;
    notifyListeners();

    final headers = await ApiHeaders.withStoredToken();

    final res = await ApiMethods().postMethod(
      method: ApiUrls.quizBookmark,
      body: {
        "attemptId": attemptId,
        "questionId": questionId,
        "isBookmarked": isBookmarked
      },
      header: headers,
    );

    if (res.isEmpty) return;
  }

}
