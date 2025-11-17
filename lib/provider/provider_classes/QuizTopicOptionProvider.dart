import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/QuizTopicOptionModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';

class QuizTopicOptionProvider extends ChangeNotifier {
  QuizTopicOptionModel? quizModel;
  bool isLoading = false;

  Future<void> fetchQuizTopics(BuildContext context, String topicId) async {
    try {
      CommonLoaderApi.show(context);
      final headers = await ApiHeaders.withStoredToken();
      final response = await ApiMethods().getMethod(
        method: ApiUrls.quizTopic.replaceFirst(":topicId", topicId),
        body: {},
        header: headers,
      );
      CommonLoaderApi.hide(context);
      if (response.isNotEmpty) {
        quizModel = quizTopicOptionModelFromJson(response);
      }
    } catch (e) {
      Helper.customToast("Failed to load quizzes");
    }
  }
}
