import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/HomeDataModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

class HomeProvider with ChangeNotifier {
  HomeDataModel? homeData;

  bool isLoading = false;
  String errorMessage = "";
  int selectedDeckIndex = -1;



  // ---------------- TIMER FOR LIVE TEST ----------------
  Timer? liveTestTimer;
  int remainingSeconds = 0;

  void startLiveTestTimer(int seconds) {
    remainingSeconds = seconds;

    liveTestTimer?.cancel(); // old timer stop

    liveTestTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 0) {
        timer.cancel();
      } else {
        remainingSeconds--;
      }
      notifyListeners(); // update UI
    });
  }

  /// ---------------- API CALL ----------------
  Future<void> fetchHomeData(
    BuildContext context, {
    bool showLoader = true,
  }) async {
    errorMessage = "";
    if (showLoader && context.mounted) CommonLoaderApi.show(context);

    try {
      final headers = await ApiHeaders.withStoredToken();

      final response = await ApiMethods().getMethodTwo(
        method: ApiUrls.homeDashboard,
        header: headers,
        body: {},
      );

      if (showLoader && context.mounted) CommonLoaderApi.hide(context);
      if (response.isNotEmpty) {
        homeData = homeDataModelFromJson(response);
        if (homeData?.data?.liveTest?.timeToStart != null) {
          startLiveTestTimer(homeData!.data!.liveTest!.timeToStart!);
        }

        notifyListeners();
      }
    } catch (e, st) {
      debugPrint("Exception in fetchHomeData: $e\n$st");
      errorMessage = "Something went wrong: $e";
      Helper.customToast(errorMessage);
    }
  }

  void setSelectedDeckIndex(int index) {
    selectedDeckIndex = index;
    notifyListeners();
  }
}
