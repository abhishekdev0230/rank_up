import 'package:flutter/material.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/views/FlashcardQ/DimensionalAnalysis/OptionTileWidget.dart';
import 'package:rank_up/views/Home/home_view.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class DimensionAlanalysisTest extends StatefulWidget {
  const DimensionAlanalysisTest({super.key});

  @override
  State<DimensionAlanalysisTest> createState() =>
      _DimensionAlanalysisTestState();
}

class _DimensionAlanalysisTestState extends State<DimensionAlanalysisTest> {
  bool isCorrect = false;
  bool showCompleted = false;

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      padding: false,
      backgroundColor: MyColors.appTheme,
      title: "Dimensional Analysis",
      body: Column(
        children: [
          // Progress bar
          hSized15,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 6,
                  decoration: BoxDecoration(
                    color: MyColors.whiteText,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.4, // example progress
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.color19B287,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                hSized10,

                // Question number and timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Q. 1/10",
                      style: semiBoldTextStyle(color: MyColors.whiteText),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.white, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          "15:00",
                          style: regularTextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                hSized30,

                // Question card
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Q: What is the dimensional formula for Force?",
                        textAlign: TextAlign.center,
                        style: semiBoldTextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      hSized12,

                      ResponsiveGridList(
                        shrinkWrap: true,
                        minItemWidth: (MediaQuery.of(context).size.width - 64) / 2,
                        minItemsPerRow: 2,
                        maxItemsPerRow: 2,
                        children: [
                          OptionTileWidget(
                            "A. M L T",
                            isCorrect: false,
                            isSelected: !isCorrect,
                          ),
                          OptionTileWidget(
                            "B. M L / T²",
                            isCorrect: true,
                            isSelected: isCorrect,
                          ),
                          OptionTileWidget(
                            "C. M / L T",
                            isCorrect: false,
                            isSelected: false,
                          ),
                          OptionTileWidget(
                            "D. M L T²",
                            isCorrect: false,
                            isSelected: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                hSized30,
                CommonButton1(
                  height: 32,
                  width: 103,
                  title: "Skip",
                  onPressed: onToggleAnswer,
                ),
                hSized20,
              ],
            ),
          ),
          Spacer(),
          // Navigation buttons
          Container(
            height: 67,
            width: double.infinity,
            color: MyColors.color295176,

            child: Row(
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
          ),
        ],
      ),
    );
  }

  void onToggleAnswer() {
    setState(() {
      isCorrect = !isCorrect;
      showCompleted = true;
    });
  }
}
