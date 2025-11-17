import 'package:flutter/material.dart';
import 'package:rank_up/models/StartQuizModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';

class QuizStartProvider extends ChangeNotifier {
  bool isLoading = false;
  StartQuizModel? startQuizModel;

  Future<void> startQuiz(BuildContext context, String quizId) async {
    isLoading = true;
    notifyListeners();

    try {
      final headers = await ApiHeaders.withStoredToken();
      final response = await ApiMethods().postMethod(
        method: ApiUrls.quizStart,
        body: {"quizId": quizId},
        header: headers,
      );

      startQuizModel = startQuizModelFromJson(response);
    } catch (e) {
      Helper.customToast("Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
