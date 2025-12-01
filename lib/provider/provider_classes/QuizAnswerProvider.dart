import 'package:flutter/material.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/QuizAnsModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/services/common_response.dart';

class QuizAnswerProvider extends ChangeNotifier {
  QuizAnsModel? quizAnsModel;

  /// Store selected answer per question
  final Map<String, String> _selectedAnswers = {}; // key: questionId, value: optionId

  /// Get selected answer for a question
  String? getSelectedAnswer(String questionId) {
    return _selectedAnswers[questionId];
  }

  /// Save selected answer for a question
  void setAnswer(String questionId, String optionId) {
    _selectedAnswers[questionId] = optionId;
    notifyListeners();
  }
  String? getAnswerOrSubmitted(String questionId) {
    if (_selectedAnswers.containsKey(questionId)) {
      return _selectedAnswers[questionId];
    }
    // fallback: use submitted answer from API if available
    return quizAnsModel?.data?.questionId == questionId
        ? quizAnsModel?.data?.selectedAnswer
        : null;
  }

  void clearAnswer() {
    quizAnsModel = null;
    notifyListeners();
  }

  Future<void> submitAnswer({
    required BuildContext context,
    required String attemptId,
    required String questionId,
    required String optionId, // pass optionId instead of optionLabel
    required String selectedAnswer, // the text of the option
    required int timeTaken,
  }) async {
    CommonLoaderApi.show(context);

    try {
      final endpoint = ApiUrls.quizAns.replaceAll(":attemptId", attemptId);

      final body = {
        "questionId": questionId,
        "selectedAnswer": selectedAnswer, // still send text to API
        "timeTaken": timeTaken,
      };

      final res = await ApiMethods().postMethod(
        method: endpoint,
        body: body,
        header: await ApiHeaders.withStoredToken(),
      );

      final decoded = commonResponseFromJson(res);
      CommonLoaderApi.hide(context);

      if (decoded.status == true) {
        quizAnsModel = quizAnsModelFromJson(res);

        // Save selected optionId locally
        setAnswer(questionId, optionId);
      } else {
        Helper.customToast(decoded.message ?? "Something went wrong");
      }
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Error submitting answer");
    }
  }
}

