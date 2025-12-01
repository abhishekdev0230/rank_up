import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/TestResumeBottomModel.dart';
import 'package:rank_up/models/TestScreenModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/services/common_response.dart';
import 'package:rank_up/views/Home/home_view.dart';
import '../../Utils/helper.dart';
import '../../views/tests_screen/ShowStartTestDialog.dart';

class TestLeaderboardProvider extends ChangeNotifier {
  TestScreenModel? testModel;
  TestResumeBottom? resumeData;
  Future<void> fetchDashboard(BuildContext context, {bool isRefresh = false}) async {

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

  Widget testActionButton({
    required String buttonState,
    required VoidCallback? onStart,
    required VoidCallback? onEnroll,
    required VoidCallback? onUpgrade,
    required VoidCallback? onResume,
    required VoidCallback? onViewResult,
  }) {
    double w = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    switch (buttonState) {

      case "START":
        return CommonButton1(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),  // <-- FIXED
          bgColor: MyColors.appTheme,
          textColor: Colors.white,
          title: "Start Test",
          onPressed: onStart,
        );

      case "ENROLL":
        return CommonButton1(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          bgColor: Colors.white,
          textColor: MyColors.appTheme,
          borderColor: MyColors.appTheme,
          title: "Enroll",
          onPressed: onEnroll,
        );

      case "UPGRADE":
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock, color: Colors.white, size: 22),
            const SizedBox(width: 8),

            Flexible(
              fit: FlexFit.loose,
              child: CommonButton1(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: w * 0.010),
                bgColor: Colors.white,
                textColor: MyColors.appTheme,
                borderColor: MyColors.appTheme,
                title: "Upgrade",
                onPressed: onUpgrade,
              ),
            ),
          ],
        );


      case "UPCOMING":
        return CommonButton1(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: w * 0.010),
          bgColor: MyColors.colorD5D5D5,
          textColor: Colors.white,
          title: "Upcoming",
          onPressed: null,   // disabled
        );

      case "CLOSED":
        return CommonButton1(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          bgColor: MyColors.blackColor.withOpacity(0.5),
          textColor: Colors.white,
          title: "Expired",
          onPressed: null,
        );

      case "RESUME":
        return CommonButton1(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          bgColor: MyColors.appTheme,
          textColor: Colors.white,
          title: "Resume",
          onPressed: onResume,
        );

      case "VIEW_RESULT":
        return CommonButton1(
          height: 30,
          fontSize: 10,
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          bgColor: MyColors.appTheme,
          textColor: Colors.white,
          title: "View Result",
          onPressed: onViewResult,
        );

      default:
        return const SizedBox();
    }
  }


  Future<void> testsEnroll(BuildContext context, String testId) async {
    CommonLoaderApi.show(context);

    final headers = await ApiHeaders.withStoredToken();
    final String url = ApiUrls.testsEnroll.replaceFirst(':id', testId);

    debugPrint("📘 tests Enroll → $url");

    final CommonResponse? response = await ApiMethods().postMethodCM(
      header: headers,
      method: url,
      body: {},
    );

    CommonLoaderApi.hide(context);

    if (response == null) {
      Helper.customToast("Something went wrong");
      return;
    }

    if (response.status == true) {
      Helper.customToast(response.message ?? "Enrolled Successfully!");

      await fetchDashboard(context, isRefresh: true);

      notifyListeners();
    } else {
      Helper.customToast(response.message ?? "Something went wrong");
    }
  }

  Future<void> testsEnrollStart(BuildContext context,String testId,title) async {
    CommonLoaderApi.show(context);
    final String url = ApiUrls.testsEnrollStart.replaceFirst(':id', testId);
    final res = await ApiMethods().getMethodTwo(
      method: url,
      body: {},
      header: await ApiHeaders.withStoredToken(),
    );


    if (res.isEmpty) {
      Helper.customToast("Failed to load data");
      return;
    }

    final TestResumeBottomModel data = testResumeBottomModelFromJson(res);
    CommonLoaderApi.hide(context);
    if (data.status == true) {
      resumeData = data.data;   // store model
      GrandTestShowInstructionDialog.show(context,resumeData!,testId,title);
      notifyListeners();
    } else {
      Helper.customToast(data.message ?? "Something went wrong");
    }
  }




}
