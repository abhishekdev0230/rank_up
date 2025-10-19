import 'package:flutter/material.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/views/Home/home_view.dart';
import 'package:rank_up/views/bottom_navigation_bar.dart';

import '../../onboarding_screen/onboarding_screen.dart';

class QuizCompletedWidget extends StatelessWidget {
  const QuizCompletedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hSized20,
          Text(
            "Quiz Completed!",
            style: semiBoldTextStyle(color: Colors.white, fontSize: 20),
          ),
          hSized20,
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.rankBg,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Your solved 10 MCQs",
                  style: mediumTextStyle(fontSize: 16),
                ),
                hSized20,
                SizedBox(
                  height: 170,
                  width: 170,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(170, 170),
                        painter: RoundedCircularProgressPainter(
                          progress: 0.6,
                          color: MyColors.color19B287,
                          backgroundColor: MyColors.whiteText,
                          strokeWidth: 10,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "80%",
                            style: semiBoldTextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            textAlign: TextAlign.center,
                            "Better than your\n peers",
                            style: regularTextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                hSized24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle, color: Colors.green, size: 5),
                        wSized5,
                        Text(
                          "8 Correct (80%)",
                          style: mediumTextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.circle, color: Colors.red, size: 5),
                        wSized5,
                        Text(
                          "2 Incorrect (20%)",
                          style: mediumTextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                hSized20,
                Row(
                  children: [
                    Text(
                      "Time Taken:",
                      style: regularTextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "12:35/15:00 Min",
                      style: regularTextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Total Attempts:",
                      style: regularTextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "8/10",
                      style: regularTextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                hSized40,
                Row(
                  children: [
                    Expanded(
                      child: CommonButton1(
                        title: "Review Answer",
                        height: 47,
                        bgColor: MyColors.color19B287,
                        onPressed: () {},
                      ),
                    ),
                    wSized10,
                    Expanded(
                      child: CommonButton1(
                        title: "Back to \nDimensional Analysis",
                        height: 47,
                        bgColor: MyColors.appTheme,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          hSized30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Question: 10",
                style: regularTextStyle(color: Colors.white, fontSize: 13),
              ),
              Text(
                "Correct: 8",
                style: regularTextStyle(color: Colors.white, fontSize: 13),
              ),
              Text(
                "Incorrect: 2",
                style: regularTextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
          hSized10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bookmarked: 0",
                style: regularTextStyle(color: Colors.white, fontSize: 13),
              ),

              Text(
                "Schema MCQs: 0",
                style: regularTextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: context.wp(1 / 4)),
          Center(
            child: CommonButton1(
              width: 150,
              title: "<<< Back to Home",
              height: 35,
              textColor: Colors.black,
              bgColor: MyColors.rankBg,
              onPressed: () {

                CustomNavigator.pushRemoveUntil(context,   BottomNavController(initialIndex: 0),);

              },
            ),
          ),
        ],
      ),
    );
  }
}
