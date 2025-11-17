import 'package:flutter/material.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/QuizAnsModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/services/common_response.dart';

class QuizAnswerProvider extends ChangeNotifier {
  QuizAnsModel? quizAnsModel;

  Future<void> submitAnswer({
    required BuildContext context,
    required String attemptId,
    required String questionId,
    required String selectedAnswer,
    required int timeTaken,
  }) async {
    CommonLoaderApi.show(context);
    notifyListeners();

    try {
      final endpoint = ApiUrls.quizAns.replaceAll(":attemptId", attemptId);

      final body = {
        "questionId": questionId,
        "selectedAnswer": selectedAnswer,
        "timeTaken": timeTaken,
      };

      final res = await ApiMethods().postMethod(
        method: endpoint,
        body: body,
        header: await ApiHeaders.withStoredToken(),
      );

      final decoded = commonResponseFromJson(res);
      CommonLoaderApi.hide(context);
      notifyListeners();
      if (decoded.status == true) {
        quizAnsModel = quizAnsModelFromJson(res);
      } else {
        Helper.customToast(decoded.message ?? "Something went wrong");
      }
    } catch (e) {
      Helper.customToast("Error submitting answer");
    }


  }

}
