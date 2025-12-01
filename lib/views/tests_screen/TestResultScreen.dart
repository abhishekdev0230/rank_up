import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/models/TestReviewAnswerModel.dart';
import 'package:rank_up/provider/provider_classes/TestStartProvider.dart';
import 'package:rank_up/views/Home/home_view.dart' show CommonButton1;
import 'package:rank_up/views/tests_screen/FullAnalyticsScreen.dart';
import '../../Utils/CommonButton.dart';
import '../../Utils/helper.dart';
import '../../constraints/my_fonts_style.dart';
import '../../constraints/sizedbox_height.dart';
import '../../custom_classes/validators.dart';
import '../FlashcardQ/DimensionalAnalysis/review_screen.dart';
import '../bottom_navigation_bar.dart' show BottomNavController;

class TestResultScreen extends StatelessWidget {
  final TestReviewAnswerModel reviewModel;

  const TestResultScreen({
    super.key,
    required this.reviewModel,
  });

  @override
  Widget build(BuildContext context) {

    final meta = reviewModel.data?.attemptMeta;

    final testName = meta?.test?.title ?? "Test";
    final date = CommonValidators.formatDate(meta?.completedAt?.split(" ").first ?? "");
    final correct = meta?.correctAnswers ?? 0;
    final incorrect = meta?.incorrectAnswers ?? 0;
    final skip = meta?.skippedQuestions ?? 0;
    final total = meta?.totalQuestions ?? 0;
    final percentile = meta?.percentage ?? 0;
    final predictedRank = meta?.rank ?? 0;

    /// Progress calculation (0–100)
    final progress = ((correct / total) * 100).clamp(0, 100);

    return CommonScaffold(
      title: testName,
      showBack: false,
      backgroundColor: MyColors.appTheme,
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// ------------ TOP BLUE HEADER -------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: MyColors.appTheme,
              ),
              child: Column(
                children: [
                  Text(
                    "Taken on $date",
                    style: regularTextStyle(color: MyColors.whiteText, fontSize: 19),
                  ),
                  hSized10,

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    decoration: BoxDecoration(
                      color: MyColors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "All India",
                      style: mediumTextStyle(color: MyColors.whiteText, fontSize: 12),
                    ),
                  ),

                  hSized20,
                  Text(
                    "Predicted Rank",
                    style: regularTextStyle(color: Colors.white, fontSize: 16),
                  ),
                  hSized15,

                  Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      SvgPicture.asset(IconsPath.liderbordBg),
                      Text(
                        textAlign: TextAlign.center,
                        "Rank \n$predictedRank",
                        style: semiBoldTextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),

                  hSized5,

                  Text(
                    // "not found",
                    "Out of ${meta?.totalScore ?? 0}",
                    style: regularTextStyle(color: Colors.white, fontSize: 22),
                  ),

                  hSized20,

                  CommonButton(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    text: "Review Answers",
                    textColor: MyColors.whiteText,
                    color: MyColors.color295176,
                    onPressed: () {
                      final provider = Provider.of<StartTestProvider>(context, listen: false);

                      final attemptId = provider.startModel?.data?.attempt?.id;

                      if (attemptId == null || attemptId.isEmpty) {
                        Helper.customToast("Attempt ID not found!");
                        return;
                      }

                      pushScreen(
                        context,
                        screen: ReviewScreen(attemptId: attemptId),
                        withNavBar: false,
                      );
                    },
                  ),

                ],
              ),
            ),

            /// ---------------- LOWER WHITE BODY ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: MyColors.rankBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    "You solved $total MCQs",
                    style: mediumTextStyle(fontSize: 16, color: MyColors.blackColor),
                  ),
                  hSized5,

                  Text(
                    "$percentile% Percentile",
                    style: mediumTextStyle(fontSize: 16, color: MyColors.blackColor),
                  ),

                  hSized20,

                  /// ----------- CIRCULAR PROGRESS -----------
                  SizedBox(
                    height: 170,
                    width: 170,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(170, 170),
                          painter: RoundedCircularProgressPainter(
                            progress: progress.toDouble(),
                            color: MyColors.color19B287,
                            backgroundColor: Colors.grey.shade300,
                            strokeWidth: 10,
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${progress.toStringAsFixed(0)}%",
                              style: semiBoldTextStyle(fontSize: 30, color: Colors.black),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Better than\n${meta?.totalScore ?? 0}% students",
                              textAlign: TextAlign.center,
                              style: regularTextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  hSized25,

                  /// ----------- STATS ROW -----------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, color: MyColors.color32B790, size: 8),
                      SizedBox(width: 6),
                      Text(
                        "$correct Correct (${(correct / total * 100).toStringAsFixed(0)}%)",
                        style: mediumTextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.circle, color: MyColors.colorD84B48, size: 8),
                      SizedBox(width: 6),
                      Text(
                        "$incorrect Incorrect",
                        style: mediumTextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, color: MyColors.colorF8CB52, size: 8),
                      SizedBox(width: 6),
                      Text(
                        "$skip Skipped",
                        style: mediumTextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),

                  hSized20,

                  Row(
                    children: [
                      Text("Time Taken: ", style: regularTextStyle(color: Colors.black, fontSize: 13),),
                      Text("${meta?.timeTaken ?? 0} sec",  style: regularTextStyle(color: Colors.black, fontSize: 13),),
                      Spacer(),
                      Text("Attempted: ",  style: regularTextStyle(color: Colors.black, fontSize: 13),),
                      Text("${meta?.attemptedQuestions ?? 0}/$total",
                          style:  regularTextStyle(color: Colors.black, fontSize: 13),),
                    ],
                  ),

                  hSized24,
                  CommonButton(
                    text: "Full Analytics",
                    color: MyColors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      final provider = Provider.of<StartTestProvider>(context, listen: false);
                      final attemptId = provider.startModel?.data?.attempt?.id;
                      if (attemptId == null || attemptId.isEmpty) {
                        Helper.customToast("Attempt ID not found!");
                        return;
                      }

                      pushScreen(
                        context,
                        screen: FullAnalyticsScreen(attemptId: attemptId),
                        withNavBar: false,
                      );
                    },
                  ),
                  hSized20,
                  Center(
                    child: CommonButton1(
                      width: 150,
                      title: "<<< Back to Home",
                      height: 35,
                      textColor: Colors.black,
                      bgColor: MyColors.rankBg,
                      onPressed: () {
                        pushScreen(
                          context,
                          screen: const BottomNavController(initialIndex: 0),
                          withNavBar: false,
                        );
                      },
                    ),
                  ),
                  hSized24,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
