import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/provider/provider_classes/TestLeaderboardProvider.dart';
import 'package:rank_up/views/Home/home_view.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../constraints/font_family.dart';
import '../../models/TestResumeBottomStartTestModel.dart';
import '../../models/TestScreenModel.dart';
import '../../Utils/helper.dart';
import '../../provider/provider_classes/TestStartProvider.dart';
import '../FlashcardQ/NeetPYQsFlashcardsInner.dart';
import '../me_profile/SubscriptionScreen/SubscriptionScreen.dart';

class TestLeaderboardScreen extends StatefulWidget {
  const TestLeaderboardScreen({super.key});

  @override
  State<TestLeaderboardScreen> createState() => _TestLeaderboardScreenState();
}

class _TestLeaderboardScreenState extends State<TestLeaderboardScreen> {
  String selectedTestType = "minor";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TestLeaderboardProvider>(
        context,
        listen: false,
      ).fetchDashboard(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestLeaderboardProvider>(
      builder: (context, provider, child) {
        final model = provider.testModel?.data;
        if (model == null) {
          return const Center(child: Text("No Data Found"));
        }

        return CommonScaffold(
          padding: false,
          backgroundColor: MyColors.appTheme,
          title: "Tests",
          showBack: false,

            body: RefreshIndicator(
              color: MyColors.appTheme,
              onRefresh: () async {
                await provider.fetchDashboard(context, isRefresh: true);
              },

              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        hSized20,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.horizontal,
                          ),
                          child: _testCardSection(model.featuredTest),
                        ),
                        hSized20,
                        _bottomSection(context, model),
                      ],
                    ),
                  ),
                ],
              ),
            )

        );
      },
    );
  }

  Widget featuredTestButton(FeaturedTest test) {
    final provider = Provider.of<TestLeaderboardProvider>(
      context,
      listen: false,
    );

    if (test.isPremium != true && test.isEnrolled == false) {
      return provider.testActionButton(
        buttonState: "UPGRADE",
        onStart: null,
        onEnroll: null,
        onUpgrade: () {
          CustomNavigator.pushNavigate(context, SubscriptionScreen());
        },
        onResume: null,
        onViewResult: null,
      );
    }

    // Otherwise → follow buttonState normally
    return provider.testActionButton(
      buttonState: test.buttonState ?? "",

      onStart: () {
        // GrandTestShowInstructionDialog.show(context);
      },

      onEnroll: () {
        provider.testsEnroll(context, test.id ?? "");
      },

      onUpgrade: () {
        CustomNavigator.pushNavigate(context, SubscriptionScreen());
      },

      onResume: () {
        provider.testsEnrollStart(context, test.id ?? "", test.title ?? "");
      },

      onViewResult: () {
        Helper.customToast("Opening Result…");
      },
    );
  }

  // FEATURED TEST CARD
  Widget _testCardSection(FeaturedTest? test) {
    if (test == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColors.color295176,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "No Featured Test Available",
          style: semiBoldTextStyle(fontSize: 18, color: MyColors.whiteText),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.color295176,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---- TITLE + DATE ----
          Text(
            "${test.title ?? "No Title"}\n"
                "${test.startDate != null ? test.startDate!.toLocal().toString().substring(0, 10) : ""}",
            style: semiBoldTextStyle(fontSize: 18, color: MyColors.whiteText),
          ),

          const SizedBox(height: 8),

          /// ---- DESCRIPTION ----
          Text(
            test.description ?? "No Description",
            style: boldTextStyle(fontSize: 14, color: MyColors.whiteText),
          ),

          const SizedBox(height: 16),

          /// ---- BUTTON + ICON ----
          Row(
            children: [
              featuredTestButton(test),

              const Spacer(),

              Icon(
                test.isPremium == true ? Icons.lock : Icons.check_circle,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _bottomSection(BuildContext context, TestScreenData model) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.rankBgD8D8D8,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hSized20,
            _dailyPracticeCard(context, model.dailyPractice),
            hSized20,
            Text(
              "Upcoming Tests",
              style: semiBoldTextStyle(
                fontSize: 19,
                color: MyColors.blackColor,
              ),
            ),
            hSized15,

            /// Minor + Major Buttons
            Row(
              children: [
                Expanded(
                  child: _testTypeButton(
                    "Minor Test",
                    isSelected: selectedTestType == "minor",
                    onTap: () {
                      setState(() {
                        selectedTestType = "minor";
                      });
                    },
                  ),
                ),
                wSized10,
                Expanded(
                  child: _testTypeButton(
                    "Major Test",
                    isSelected: selectedTestType == "major",
                    onTap: () {
                      setState(() {
                        selectedTestType = "major";
                      });
                    },
                  ),
                ),
              ],
            ),

            hSized15,
            ResponsiveGridList(
              listViewBuilderOptions: ListViewBuilderOptions(
                physics: const NeverScrollableScrollPhysics(),
              ),
              shrinkWrap: true,
              minItemWidth: 160,
              horizontalGridSpacing: 10,
              verticalGridSpacing: 10,

              /// 🔥 Dynamic List Switching
              children:
                  (selectedTestType == "minor"
                          ? (model.upcomingTests?.minor ?? [])
                          : (model.upcomingTests?.major ?? []))
                      .map((e) => _upcomingTestCard(e))
                      .toList(),
            ),

            hSized20,
            Text(
              "Leaderboard",
              style: semiBoldTextStyle(
                fontSize: 19,
                color: MyColors.blackColor,
              ),
            ),
            hSized15,
            _leaderboardSection(model.leaderboard),
            hSized20,
          ],
        ),
      ),
    );
  }

  // DAILY PRACTICE
  Widget _dailyPracticeCard(BuildContext ctx, DailyPractice? daily) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.whiteText,
        border: Border.all(color: MyColors.hintTextFieldBorderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Daily Practice", style: semiBoldTextStyle(fontSize: 18)),
              const Spacer(),
              Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message:
                    "Daily Practice gives you fresh questions every day. It's a quick way to stay consistent and improve.",
                textStyle: TextStyle(fontSize: 14, color: Colors.white),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.info_outline),
              ),
            ],
          ),
          Text(
            daily?.isCompleted == true ? "Completed Today" : "Not Completed",
            style: regularTextStyle(fontSize: 15, color: MyColors.color949494),
          ),
          hSized20,
          CommonButton1(
            width: 150,
            bgColor: MyColors.appTheme,
            textColor: Colors.white,
            title: "Start New Session",
            onPressed: () {
              if ((daily?.questionsToday ?? 0) != 0) {
                CustomNavigator.pushNavigate(
                  context,
                  NeetPYQsFlashcardsInner(
                    topicId: daily?.attemptId.toString() ?? "",
                  ),
                );
              } else {
                Helper.customToast("No questions available today");
              }
            },
          ),

          hSized20,
          Text(
            "${daily?.questionsToday ?? 0} New Questions await!",
            style: regularTextStyle(fontSize: 15, color: MyColors.color949494),
          ),
        ],
      ),
    );
  }

  /// Button UI Not Changed (Fully Same)
  Widget _testTypeButton(
    String title, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CommonButton1(
        height: 47,
        bgColor: isSelected ? MyColors.color19B287 : Colors.white,
        textColor: isSelected ? Colors.white : Colors.black,
        title: title,
        onPressed: onTap,
      ),
    );
  }

  Widget _upcomingTestCard(Major test) {
    final provider = Provider.of<TestLeaderboardProvider>(
      context,
      listen: false,
    );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.whiteText,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                color: MyColors.color949494,
                child: SvgPicture.asset(IconsPath.flashQ),
              ),
              wSized10,
              Expanded(
                child: Text(
                  test.title ?? "",
                  maxLines: 2,
                  style: boldTextStyle(fontSize: 12),
                ),
              ),
            ],
          ),

          hSized15,

          Row(
            children: [
              Expanded(
                child: Text(
                  "${test.duration} Mins  |  ${test.totalQuestions} Q's",
                  style: boldTextStyle(
                    fontSize: 12,
                    color: MyColors.color949494,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: provider.testActionButton(
                  buttonState: test.buttonState ?? "",

                  onStart: () {
                    print("mslkdklsklds");
                    // GrandTestShowInstructionDialog.show(context);
                  },

                  onEnroll: () async {
                    await Provider.of<TestLeaderboardProvider>(
                      context,
                      listen: false,
                    ).testsEnroll(context, test.id.toString());
                  },

                  onUpgrade: () {
                    CustomNavigator.pushNavigate(context, SubscriptionScreen());
                  },

                  onResume: () {
                    Provider.of<TestLeaderboardProvider>(
                      context,
                      listen: false,
                    ).testsEnrollStart(
                      context,
                      test.id.toString(),
                      test.title ?? "",
                    );
                  },

                  onViewResult: () {
                    final startTestProvider = Provider.of<StartTestProvider>(context, listen: false);

                    // Ensure nested objects exist
                    startTestProvider.startModel ??= TestResumeBottomStartTestModel();
                    startTestProvider.startModel!.data ??= TestData();
                    startTestProvider.startModel!.data!.attempt ??= Attempt();

                    // Directly set the attempt id
                    startTestProvider.startModel!.data!.attempt!.id = test.attemptId.toString();

                    // Call fetchResult with the same attemptId
                    startTestProvider.fetchResult(
                      context,
                      attemptId: test.attemptId.toString(),
                    );

                    Helper.customToast("Opening Result…");
                  },



                ),
              ),
            ],
          ),

          // hSized10,
        ],
      ),
    );
  }

  Widget _leaderboardSection(Leaderboard? data) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.whiteText,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: LeaderboardChart(
        averageScore: data?.averageScore ?? 0,
        solved: data?.solved ?? 0,
        total: data?.total ?? 1,
        size: 120,
      ),
    );
  }
}
