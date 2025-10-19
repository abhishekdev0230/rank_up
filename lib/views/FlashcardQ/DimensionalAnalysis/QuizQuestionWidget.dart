import 'package:flutter/material.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'OptionTileWidget.dart';
import 'package:rank_up/views/Home/home_view.dart';

class QuizQuestionWidget extends StatelessWidget {
  final bool isCorrect;
  final VoidCallback onToggleAnswer;

  const QuizQuestionWidget({
    super.key,
    required this.isCorrect,
    required this.onToggleAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          hSized20,

          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: MyColors.whiteText,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.4,
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.color19B287,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          hSized10,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Q. 1/10",
                style: semiBoldTextStyle(color: MyColors.whiteText),
              ),
              Row(
                children: [
                  Icon(Icons.timer, color: Colors.white, size: 18),
                  SizedBox(width: 5),
                  Text("15:00", style: regularTextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          hSized30,

          // White Card: Question text
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Q: What is the dimensional formula for Force?",
                  style: semiBoldTextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 72) / 2,
                  child: OptionTileWidget(
                    "A. M L T",
                    isCorrect: false,
                    isSelected: !isCorrect,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 72) / 2,
                  child: OptionTileWidget(
                    "B. M L / T²",
                    isCorrect: true,
                    isSelected: isCorrect,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 72) / 2,
                  child: OptionTileWidget(
                    "C. M / L T",
                    isCorrect: false,
                    isSelected: false,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 72) / 2,
                  child: OptionTileWidget(
                    "D. M L T²",
                    isCorrect: false,
                    isSelected: false,
                  ),
                ),
              ],
            ),
          ),
          hSized20,

          // Detailed Explanation Card (with border & padding)
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detailed Explanation",
                  style: semiBoldTextStyle(fontSize: 16),
                ),
                hSized10,
                Text(
                  isCorrect
                      ? "Correct Answer: B. (M L T⁻²)"
                      : "Incorrect Answer: B. (M L T⁻²)",
                  style: semiBoldTextStyle(
                    color: isCorrect
                        ? MyColors.color19B287
                        : MyColors.colorFF0000,
                    fontSize: 14,
                  ),
                ),
                hSized10,
                Text(
                  "The dimensional formula for force is from Newton's Second law: F = m × a, where ‘m’ is mass and ‘a’ is acceleration. Acceleration is L/T². So, F = M × (L/T²) = [M L T⁻²].",
                  style: regularTextStyle(color: Colors.black),
                ),
              ],
            ),
          ),

          hSized20,
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isCorrect ? MyColors.color19B287 : MyColors.colorFF0000,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              isCorrect ? "(80%) Correct Answer" : "(53%) Incorrect Answer",
              style: semiBoldTextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(height: context.wp(1 / 4.7)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonButton1(
                  height: 47,
                  bgColor: MyColors.color295176,
                  title: "Previous",
                  onPressed: () {},
                ),
              ),
              wSized10,
              Expanded(
                child: CommonButton1(
                  height: 47,
                  title: "Next",
                  onPressed: onToggleAnswer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
