import 'package:flutter/material.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/TestScreenModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import '../../Utils/helper.dart';

class TestLeaderboardProvider extends ChangeNotifier {
  TestScreenModel? testModel;

  /// 👉 isRefresh = true → pull-to-refresh से बुलाया गया है
  /// 👉 isRefresh = false → पहली बार load हो रहा है (Loader दिखेगा)
  Future<void> fetchDashboard(BuildContext context, {bool isRefresh = false}) async {

    // ❌ Loader सिर्फ पहली बार दिखेगा, refresh पर नहीं
    if (!isRefresh) {
      CommonLoaderApi.show(context);
    }

    final res = await ApiMethods().getMethodTwo(
      method: ApiUrls.testsDashboard,
      body: {},
      header: await ApiHeaders.withStoredToken(),
    );

    if (!isRefresh) {
      CommonLoaderApi.hide(context);
    }

    if (res.isEmpty) {
      Helper.customToast("Failed to load data");
      return;
    }

    final data = testScreenModelFromJson(res);

    if (data.status == true) {
      testModel = data;
      notifyListeners();
    } else {
      Helper.customToast(data.message ?? "Something went wrong");
    }
  }
}
