import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/models/LeaderboardModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

import '../../services/local_storage.dart';
import '../../views/authentication/RankUpLoginScreen.dart';

class LeaderboardProvider extends ChangeNotifier {
  bool isLoading = false;

  final List<String> filters = ["all", "30", "7"];

  /// 0 = all time, 1 = 30 days, 2 = 7 days
  List<List<LeaderboardUser>> leaderboardData = [[], [], []];

  Future<void> fetchLeaderboard() async {
    isLoading = true;
    notifyListeners();

    for (int i = 0; i < filters.length; i++) {
      final url =
          "${ApiUrls.baseUrl}leaderboard/?filter=${filters[i]}";

      final res = await ApiMethods().getMethod(
        method: url,
        body: {},
        header: await ApiHeaders.withStoredToken(),
      );

      if (res.isNotEmpty) {
        final jsonData = jsonDecode(res);
        final list = jsonData['data'] as List;

        leaderboardData[i] =
            list.map((e) => LeaderboardUser.fromJson(e)).toList();
      }
    }

    isLoading = false;
    notifyListeners();
  }
}
