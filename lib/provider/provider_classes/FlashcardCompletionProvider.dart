import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/FlashcardsQuestionsCompletionModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';

class FlashcardCompletionProvider extends ChangeNotifier {
  FlashcardsQuestionsCompletionModel? completionModel;

  Future<void> fetchCompletionData(BuildContext context, String topicId) async {
    try {
      CommonLoaderApi.show(context);
      final headers = await ApiHeaders.withStoredToken();
      final String url = ApiUrls.flashcardsTopicsQuetionsCompletion
          .replaceFirst(':topicId', topicId);

      debugPrint("📘 Fetching Flashcard Completion Data → $url");

      final response = await ApiMethods().getMethodTwo(
        header: headers,
        method: url,
        body: {},
      );
      CommonLoaderApi.hide(context);
      if (response.isNotEmpty) {
        final jsonData = jsonDecode(response);
        completionModel = FlashcardsQuestionsCompletionModel.fromJson(jsonData);
        notifyListeners();
      } else {
        debugPrint("⚠️ Empty response from API");
        Helper.customToast("No data found");
      }
    } catch (e, st) {
      debugPrint("❌ Flashcards Completion API Error: $e");
      debugPrint(st.toString());
      Helper.customToast("Something went wrong");
    }
  }

  Data? get data => completionModel?.data;
  Statistics? get stats => completionModel?.data?.statistics;
}
