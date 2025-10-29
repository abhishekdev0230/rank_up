import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/views/Home/home_view.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../Utils/helper.dart';
import 'ShowStartTestDialog.dart';

class TestLeaderboardScreen extends StatelessWidget {
  const TestLeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      padding: false,
      backgroundColor: MyColors.appTheme,
      title: "Tests",
      showBack: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hSized20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
              child: _testCardSection(),
            ),
            const SizedBox(height: 20),
            _bottomSection(context),
          ],
        ),
      ),
    );
  }

  Widget _testCardSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.color295176,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "NEET Mock Test Series - #1\nMay 25, 2025",
            style: semiBoldTextStyle(fontSize: 18, color: MyColors.whiteText),
          ),
          const SizedBox(height: 8),
          Text(
            "Full Syllabus",
            style: boldTextStyle(fontSize: 14, color: MyColors.whiteText),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonButton1(
                bgColor: Colors.white,
                textColor: MyColors.appTheme,
                title: "Enroll/Start Test",
                onPressed: () {},
              ),
              const Icon(Icons.check_circle, color: Colors.white, size: 28),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomSection(BuildContext context) {
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
            _dailyPracticeCard(context),
            hSized20,
            Text(
              "Upcoming Tests",
              style: semiBoldTextStyle(
                fontSize: 19,
                color: MyColors.blackColor,
              ),
            ),
            hSized15,
            Row(
              children: [
                Expanded(child: _testTypeButton("Minor Test")),
                wSized10,
                Expanded(
                  child: _testTypeButton(
                    "Major Test",
                    bgColor: Colors.white,
                    textColor: Colors.black,
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
              minItemsPerRow: 2,
              maxItemsPerRow: 4,
              children: List.generate(4, (index) => _upcomingTestCard()),
            ),

            hSized20,
            _leaderboardSection(),
            hSized20,
          ],
        ),
      ),
    );
  }

  Widget _dailyPracticeCard(BuildContext context) {
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
              Text(
                "Daily Practice",
                style: semiBoldTextStyle(fontSize: 18, color: MyColors.blackColor),
              ),
              const Spacer(),
              const Icon(Icons.info_outline, color: Colors.black),
            ],
          ),
          Text(
            "Full Syllabus",
            style: regularTextStyle(fontSize: 15, color: MyColors.color949494),
          ),
          hSized20,
          CommonButton1(
            width: 150,
            bgColor: MyColors.appTheme,
            textColor: MyColors.whiteText,
            title: "Start New Session",
            onPressed: () {
              GrandTestShowInstructionDialog.show(context);
            },
          ),
          hSized20,
          Text(
            "30 New Questions await!",
            style: regularTextStyle(fontSize: 15, color: MyColors.color949494),
          ),
        ],
      ),
    );
  }


  Widget _testTypeButton(
    String title, {
    Color bgColor = MyColors.appTheme,
    Color textColor = Colors.white,
  }) {
    return CommonButton1(
      height: 47,
      bgColor: bgColor,
      textColor: textColor,
      title: title,
      onPressed: () {},
    );
  }

  Widget _upcomingTestCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.whiteText,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: MyColors.color949494,
                child: SvgPicture.asset(IconsPath.flashQ),
              ),
              wSized10,
              Expanded(
                child: Text(
                  "Biology: Cell Cycle & Division",
                  style: boldTextStyle(
                    fontSize: 12,
                    color: MyColors.blackColor,
                  ),
                ),
              ),
            ],
          ),
          hSized15,
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  "30 Mins 15 Q’s",
                  style: boldTextStyle(
                    fontSize: 12,
                    color: MyColors.color949494,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                constraints: const BoxConstraints(minHeight: 26),
                decoration: BoxDecoration(
                  color: MyColors.color32B790,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: MyColors.color32B790),
                ),
                child: Text(
                  "Enroll/Start Test",
                  textAlign: TextAlign.center,
                  style: semiBoldTextStyle(
                    fontSize: 10,
                    color: MyColors.whiteText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _leaderboardSection() {
    final List<double> weeklyScores = [50, 70, 90, 65, 80, 60, 85];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Leaderboard",
          style: semiBoldTextStyle(fontSize: 19, color: MyColors.blackColor),
        ),
        hSized10,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: MyColors.hintTextFieldBorderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    "Average Score: 72%",
                    style: semiBoldTextStyle(
                      fontSize: 16,
                      color: MyColors.blackColor,
                    ),
                  ),
                  hSized15,

                  ///.........rounded circur.........
                  SizedBox(
                    width: 120, // diameter = 2 * radius
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(120, 120),
                          painter: RoundedCircularProgressPainter(
                            progress: 0.8, // 80%
                            color: MyColors.color19B287,
                            backgroundColor: const Color(0xFFE3F7EF),
                            strokeWidth: 8,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "1200/1500",
                              style: boldTextStyle(
                                fontSize: 14,
                                color: MyColors.blackColor,
                              ),
                            ),
                            Text(
                              "Questions",
                              style: boldTextStyle(
                                fontSize: 14,
                                color: MyColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _weeklyGraph(weeklyScores),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weeklyGraph(List<double> scores) {
    const days = ["M", "T", "W", "T", "F", "S", "S"];
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: scores
                  .map(
                    (score) => Container(
                      margin: EdgeInsets.only(right: 12),
                      width: 10,
                      height: 150,
                      decoration: BoxDecoration(
                        color: MyColors.colorE4EAF0,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: score,
                          decoration: BoxDecoration(
                            color: MyColors.colore9ECEC6,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          hSized5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: days
                .map(
                  (d) => Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      d,
                      style: boldTextStyle(
                        fontSize: 10,
                        color: MyColors.blackColor,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
