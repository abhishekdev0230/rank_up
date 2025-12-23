import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/QuizCompleteModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';

class QuizCompleteProvider extends ChangeNotifier {
  QuizCompleteModel? completeModel;

  Future<void> fetchQuizComplete(BuildContext context, String attemptId, int timeTaken) async {
    CommonLoaderApi.show(context);
    notifyListeners();
print("timeTakentimeTaken$timeTaken");
    final headers = await ApiHeaders.withStoredToken();

    final response = await ApiMethods().postMethod(
      method: ApiUrls.quizComplete,
      body: {
        "attemptId": attemptId,
        "timeTaken": timeTaken
      },
      header: headers,
    );
    CommonLoaderApi.hide(context);
    if (response.isNotEmpty) {
      completeModel = quizCompleteModelFromJson(response);
      notifyListeners();
    }

  }
}
