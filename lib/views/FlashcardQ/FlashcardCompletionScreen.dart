import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';

import '../../Utils/helper.dart';
import 'DimensionalAnalysis/dimensional_analysis.dart';

class FlashcardCompletionScreen extends StatelessWidget {
  const FlashcardCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: MyColors.appTheme,
      title: "Units & Measurements",

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          hSized20,
          // ---------- Congratulations Text ----------
          Text(
            "Congratulations!",
            style: semiBoldTextStyle(color: Colors.white, fontSize: 26),
          ),
          hSized8,
          Text(
            "You’ve completed 15 out of 15 Flashcards of\nintroduction of Units",
            textAlign: TextAlign.center,
            style: regularTextStyle(color: Colors.white, fontSize: 15),
          ),

          // ---------- Circular Progress (Score Arc) ----------
          SizedBox(height: context.wp(1 / 5)),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: 160,
                height: 80,
                child: CustomPaint(
                  painter: HalfCirclePainter(
                    progress: 0.7,

                    backgroundColor: Colors.white,
                    progressColor: MyColors.color1BB287,
                    strokeWidth: 12,
                  ),
                ),
              ),

              Positioned(
                bottom: 0,

                child: Column(
                  children: [
                    Text(
                      "100%",
                      style: semiBoldTextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),

                    Text(
                      "Your Score",
                      style: regularTextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // ---------- Stats Cards Row ----------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _statCard(
                title: "Unknown Cards",
                count: "07",
                color: MyColors.colorD84B48,
                emoji: "😞",
              ),
              _statCard(
                title: "Known Cards",
                count: "13",
                color: MyColors.color1BB287,
                emoji: "😊",
              ),
              _statCard(
                title: "Highest Streak",
                count: "09",
                color: MyColors.colorF8CB52,
                emoji: "😎",
              ),
            ],
          ),
          const SizedBox(height: 40),

          // ---------- Next Topic Button ----------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: MyColors.color295176,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Solve Next Topic: Fundamental &\nDriven Units",
              textAlign: TextAlign.center,
              style: mediumTextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 25),

          // ---------- Take Quiz Button ----------
          SizedBox(
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.color1BB287,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 2),
              ),
              onPressed: () {
                pushScreen(
                  context,
                  screen: DimensionalAnalysis(type: "TackQuiz",),
                  withNavBar: false, // or false
                );
                // CustomNavigator.pushNavigate(context, DimensionalAnalysis(type: "TackQuiz",),);
              },
              child: Text(
                "Take Quiz",
                style: semiBoldTextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Small Stat Card Widget ----------
  Widget _statCard({
    required String title,
    required String count,
    required String emoji,
    required Color color,
  }) {
    return Container(
      width: 95,
      height: 115,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(
            count,
            style: semiBoldTextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: regularTextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
