import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/HomeDataModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/services/common_response.dart';

class HomeProvider with ChangeNotifier {
  // ---------------- USER INFO ----------------
  String username = "";
  String profilePicture = "";

  // ---------------- MODULES & PROGRESS ----------------
  double moduleProgress = 0.0;
  int completedModules = 0;

  // ---------------- QUESTION OF THE DAY ----------------
  String qotd = "";
  String qotdId = "";

  // ---------------- LIVE TEST ----------------
  String liveTestTitle = "";
  String liveTestTimer = "";

  // ---------------- FEATURED DECKS ----------------
  int selectedIndex = -1;
  List<Map<String, dynamic>> featuredDecks = [];
  final List<int> deckColors = [
    0xFFFF5F37,
    0xFF2DB552,
    0xFF375EC2,
    0xFFD77937,
  ];

  // ---------------- QUIZ SECTION ----------------
  String quizTitle = "";
  String quizDescription = "";

  // ---------------- ERROR STATE ----------------
  String errorMessage = "";

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // ---------------- API CALL ----------------
  Future<void> fetchHomeData(BuildContext context, {bool showLoader = true}) async {
    errorMessage = "";

    if (showLoader && context.mounted) {
      CommonLoaderApi.show(context);
    }

    try {
      Map<String, String> headers = await ApiHeaders.withStoredToken();

      final resBody = await ApiMethods().getMethodTwo(
        method: ApiUrls.homeDashboard,
        header: headers,
        body: {},
      );

      final Map<String, dynamic> jsonRes = jsonDecode(resBody);
      final res = CommonResponse.fromJson(jsonRes);

      if (showLoader && context.mounted) {
        CommonLoaderApi.hide(context);
      }

      if (res.status == true && res.data != null) {
        final homeData = Data.fromJson(res.data);

        username = homeData.user?.name ?? "";
        profilePicture = homeData.user?.profilePicture ?? "";

        completedModules = homeData.moduleProgress?.completedModules ?? 0;
        moduleProgress = (homeData.moduleProgress?.progressPercentage ?? 0) / 100;

        qotd = homeData.dailyQuestion?.questionText ?? "";
        qotdId = homeData.dailyQuestion?.id ?? "";

        featuredDecks = [];
        if (homeData.featuredDecks != null) {
          for (int i = 0; i < homeData.featuredDecks!.length; i++) {
            final deck = homeData.featuredDecks![i];
            featuredDecks.add({
              "title": deck.name ?? "",
              "id": deck.id ?? "",
              "color": deckColors[i % deckColors.length],
            });
          }
        }

        liveTestTitle = homeData.liveTest?.title ?? "";
        liveTestTimer = "${homeData.liveTest?.timeRemaining ?? 0} mins";

        if (homeData.importantTopics != null && homeData.importantTopics!.isNotEmpty) {
          quizTitle = homeData.importantTopics!.first.name ?? "";
          quizDescription = homeData.importantTopics!.first.description ?? "";
        }

        notifyListeners();
      } else {
        errorMessage = res.message ?? "Something went wrong";
        Helper.customToast(errorMessage);
      }
    } catch (e) {
      if (showLoader && context.mounted) {
        CommonLoaderApi.hide(context);
      }
      errorMessage = "Something went wrong: $e";
      Helper.customToast(errorMessage);
    }
  }


}
