import 'dart:async' show Timer;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/TestResumeBottomStartTestNextQueModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/services/common_response.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/models/TestResumeBottomStartTestModel.dart';
import 'package:rank_up/views/tests_screen/DimensionalAnalysis.dart';

import '../../models/FetchedGridStatus.dart';
import '../../models/TestReviewAnswerModel.dart';
import '../../views/tests_screen/TestResultScreen.dart';

class StartTestProvider extends ChangeNotifier {
  TestResumeBottomStartTestModel? startModel;
  NextQueData? quetionsData;
  int currentQuestionNumber = 1;
  int totalQuestion = 1;
  int duration = 1;
  int remainingSeconds = 0;
  Timer? _timer;
  String? correctOptionId;
  bool isSkip = false;

  String formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  void startTimer() {
    remainingSeconds = duration * 60;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<void> startTest(
    BuildContext context,
    String testId,
    String title, {
    bool isLiveTest = false,
    int? totalQuetion,
  }) async {
    try {
      CommonLoaderApi.show(context);

      String url = ApiUrls.testsEnrollStartTest.replaceFirst(":id", testId);
      final headers = await ApiHeaders.withStoredToken();

      Map<String, dynamic> body = {};

      if (isLiveTest) {
        body = {"isLiveTest": isLiveTest, "liveTestId": testId};
      }

      CommonResponse? response = await ApiMethods().postMethodCM(
        method: url,
        header: headers,
        body: body,
      );

      CommonLoaderApi.hide(context);

      if (response == null || response.data == null) {
        return;
      }

      startModel = TestResumeBottomStartTestModel.fromJson({
        "status": response.status,
        "message": response.message,
        "data": response.data,
      });

      if (!isLiveTest) {
        totalQuestion = startModel?.data?.attempt?.totalQuestions
            ?? startModel?.data?.test?.totalQuestions
            ?? 0;

        printFull("FULL API RESPONSE: ${response?.data}");

        print("sksssjlsfjlksfj$totalQuestion");
      } else {
        totalQuestion = totalQuetion!;

      }
      duration = startModel?.data?.test?.duration ?? 0;

      /// Start Timer
      startTimer();

      CustomNavigator.pushNavigate(
        context,
        DimensionAlanalysisTest(title: title),
      );

      notifyListeners();
    } catch (e) {
      print("🔥 Start Test Error: $e");
      CommonLoaderApi.hide(context);
    }
  }
  void printFull(String text) {
    final pattern = RegExp('.{1,900}'); // हर 900 chars में print करेगा
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  bool isBtnLoading = false;

  void goToNext(BuildContext context) async {
    if (isBtnLoading) return;

    isBtnLoading = true;
    notifyListeners();

    /// --- LAST QUESTION ---
    if (currentQuestionNumber >= totalQuestion) {
      String optionId = "";
      if (selectedOptionIndex != null && selectedOptionIndex != -1) {
        optionId =
            quetionsData?.question?.options?[selectedOptionIndex!].id ?? "";
        isSkip = false;
      } else {
        isSkip = true;
      }

      submitAnswer(context, optionId);
      testSubmitAnswer(context);

      isBtnLoading = false;
      notifyListeners();

      return;
    }

    /// --- NORMAL NEXT ---
    String optionId = "";

    if (selectedOptionIndex != null && selectedOptionIndex != -1) {
      optionId =
          quetionsData?.question?.options?[selectedOptionIndex!].id ?? "";
      isSkip = false;
    } else {
      isSkip = true;
    }

    submitAnswer(context, optionId);

    fetchNextQuestion(context, currentQuestionNumber + 1);

    isBtnLoading = false;
    notifyListeners();
  }

  void goToPrevious(BuildContext context) {
    if (currentQuestionNumber <= 1) {
      Helper.customToast("This is first question");
      return;
    }

    isSkip = false;
    fetchNextQuestion(context, currentQuestionNumber - 1);
  }

  Future<void> fetchNextQuestion(
    BuildContext context,
    int questionNumber, {
    String? routing,
  }) async {
    CommonLoaderApi.show(context);
    try {
      final attemptId = startModel?.data?.attempt?.id ?? "";
      if (attemptId.isEmpty) return;

      currentQuestionNumber = questionNumber;

      String url = ApiUrls.testsEnrollStartTestNextQue
          .replaceFirst(":attemptId", attemptId)
          .replaceFirst(":questionNumber", currentQuestionNumber.toString());

      final headers = await ApiHeaders.withStoredToken();

      String? raw = await ApiMethods().getMethod(
        method: url,
        body: {},
        header: headers,
      );

      if (raw == null || raw.isEmpty) {
        Helper.customToast("Invalid response");
        return;
      }

      final decoded = jsonDecode(raw);
      final nextModel = TestResumeBottomStartTestNextQueModel.fromJson(decoded);

      if (nextModel.status.toString() == "true") {
        quetionsData = nextModel.data;
        selectedOptionIndex = -1;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          setSelectedIndexFromPreviousAnswer();
        });

        notifyListeners();
      }
    } catch (e) {
      print("🔥 Next Question Error: $e");
    } finally {
      CommonLoaderApi.hide(context); // ✅ always hide
    }
  }

  int? selectedOptionIndex;
  void selectOption(int index) {
    selectedOptionIndex = index;
    notifyListeners();
  }

  Future<void> submitAnswer(BuildContext context, String optionId) async {
    try {
      final attemptId = startModel?.data?.attempt?.id.toString() ?? "";
      final questionId = quetionsData?.question?.id.toString() ?? "";

      if (attemptId.isEmpty || questionId.isEmpty) {
        Helper.customToast("Attempt or Question ID missing");
        return;
      }

      String url = ApiUrls.testsTestNextSaveAns.replaceFirst(
        "{attemptId}",
        attemptId,
      );

      final headers = await ApiHeaders.withStoredToken();

      final body = {
        "selectedOptionId": optionId,
        "questionId": questionId,
        "skip": isSkip,
        "timeTaken": (duration * 60 - remainingSeconds).toString(),
      };

      CommonResponse? response = await ApiMethods().postMethodCM(
        method: url,
        header: headers,
        body: body,
      );

      if (response == null) return;

      notifyListeners();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  ///................by number to jump............
  void setSelectedIndexFromPreviousAnswer() {
    final selectedId = quetionsData?.selectedAnswer;

    if (selectedId == null || selectedId.isEmpty) {
      selectedOptionIndex = -1;
      notifyListeners();
      return;
    }

    final options = quetionsData?.question?.options;

    if (options == null || options.isEmpty) {
      selectedOptionIndex = -1;
      notifyListeners();
      return;
    }

    final index = options.indexWhere((opt) => opt.id == selectedId);

    if (index != -1) {
      selectedOptionIndex = index;
    } else {
      selectedOptionIndex = -1;
    }

    notifyListeners();
  }

  ///..............bottom shit by nuber to naviget screen................................

  List<Grid> gridList = [];

  Future<void> fetchGridStatus(String attemptId) async {
    final url = ApiUrls.testsAttemptStatus.replaceAll(":attemptId", attemptId);

    final header = await ApiHeaders.withStoredToken();

    final response = await ApiMethods().getMethod(
      method: url,
      body: {},
      header: header,
    );

    if (response.isEmpty) return;

    final parsed = fetchedGridStatusFromJson(response);

    if (parsed.data != null) {
      gridList = parsed.data!.grid ?? [];
      notifyListeners();
    }
  }

  Color getStatusColor(Grid grid) {
    final s = (grid.status ?? "").toUpperCase();

    if (s.contains("ATTEMPT") ||
        s == "ATTEMPTED" ||
        grid.selectedAnswer != null && grid.selectedAnswer!.isNotEmpty) {
      return Colors.green; // User attempted the question
    }

    if (s.contains("SKIP") || grid.skip == true) {
      return MyColors.colorF8CB52;
    }

    if (s.contains("VISIT") && grid.visited == true) {
      return Colors.blueGrey.shade300; // Visited but no answer
    }

    return Colors.grey.shade400; // Not visited (default)
  }

  Color textColor(Color bg) {
    return bg.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  ///...........test submit Last api..............................
  Future<void> testSubmitAnswer(BuildContext context) async {
    try {
      final attemptId = startModel?.data?.attempt?.id.toString() ?? "";
      if (attemptId.isEmpty) {
        Helper.customToast("Attempt ID missing");
        return;
      }

      CommonLoaderApi.show(context);

      String url = ApiUrls.testsFinelSubmit.replaceFirst(
        ":attemptId",
        attemptId,
      );

      final headers = await ApiHeaders.withStoredToken();

      final body = {"timeTaken": (duration * 60 - remainingSeconds).toString()};

      CommonResponse? response = await ApiMethods().postMethodCM(
        method: url,
        header: headers,
        body: body,
      );

      /// ---------------------------
      /// ALWAYS HIDE LOADER
      /// ---------------------------
      CommonLoaderApi.hide(context);

      if (response == null) return;

      /// ---------------------------
      /// CASE 1 → Already Submitted
      /// ---------------------------
      if (response.statusCode == 400 &&
          response.message.toString().contains("Attempt already submitted")) {
        print("⚠️ Already submitted → Going to result");

        await fetchResult(context);
        return;
      }

      /// ---------------------------
      /// CASE 2 → Normal Success
      /// ---------------------------
      if (response.status.toString() == "true") {
        await fetchResult(context);
      }
    } catch (e) {
      CommonLoaderApi.hide(context);
      print("🔥 ERROR testSubmitAnswer: $e");
    }
  }

  /// .................... RESULT PROVIDER ............................
  TestReviewAnswerModel? reviewModel;
  Future<void> fetchResult(BuildContext context, {String? attemptId, bool route = false}) async {
    try {
      final idToUse = startModel?.data?.attempt?.id.toString()??  attemptId?.toString();
      if (idToUse!.isEmpty) {
        Helper.customToast("Attempt ID missing");
        return;
      }

      CommonLoaderApi.show(context);

      final headers = await ApiHeaders.withStoredToken();
      final raw = await ApiMethods().getMethod(
        method: ApiUrls.testsAttemptReview.replaceFirst(":attemptId", idToUse),
        header: headers,
        body: {},
      );

      CommonLoaderApi.hide(context);

      if (raw == null || raw.isEmpty) {
        Helper.customToast("Invalid API response");
        return;
      }

      final decoded = jsonDecode(raw);
      final fetchedReviewModel = TestReviewAnswerModel.fromJson(decoded);

      if (fetchedReviewModel == null) return;

      // Navigation must happen after frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.canPop(context)) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TestResultScreen(reviewModel: fetchedReviewModel),
          ),
        );
      });

    } catch (e) {
      CommonLoaderApi.hide(context);
      print("🔥 Result API Error: $e");
      Helper.customToast("Failed to fetch result");
    }
  }

}
