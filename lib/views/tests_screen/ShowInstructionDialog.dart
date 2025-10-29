import 'package:flutter/material.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/views/FlashcardQ/DimensionalAnalysis/dimensional_analysis.dart';
import 'package:rank_up/views/Home/home_view.dart';

import 'DimensionalAnalysis.dart';

class ShowInstructionDialog {
  static void showDetailedInstructions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              hSized20,
              Text(
                "Instructions",
                style: semiBoldTextStyle(
                  fontSize: 20,
                  color: MyColors.blackColor,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "1. This test is divided into 4 parts - Part 1, 2, 3 and 4.\n"
                "2. Each part will have 50 questions and is allotted 45 minutes.\n"
                "3. The next part will start automatically after you complete the previous part or when the timer for a part runs out.\n"
                "4. You cannot review/modify your responses for a part after you complete the allotted time.\n"
                "5. You will be able to submit the test once you complete all the parts.\n"
                "6. You cannot use multiple devices to take this test.\n"
                "7. Questions which are marked for review will not be considered in the final evaluation.",
                style: regularTextStyle(
                  fontSize: 12,
                  color: MyColors.color949494,
                ),
              ),
              hSized30,
              CommonButton1(
                width: 206,
                height: 45,
                title: "Yes, Continue",
                borderRadius: 30,
                bgColor: MyColors.appTheme,
                textColor: Colors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: MyColors.whiteText,
                        alignment: Alignment.center,
                        title: Center(
                          child: Text(
                            "Confirmation",
                            style: semiBoldTextStyle(
                              fontSize: 20,
                              color: MyColors.appTheme,
                            ),
                          ),
                        ),
                        content: Text(
                          "Once you start, the test timer cannot\nbe paused. Continue?",
                          textAlign: TextAlign.center,
                          style: regularTextStyle(
                            fontSize: 19,
                            color: MyColors.color949494,
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [

                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
                              children: [
                                CommonButton1(
                                  width: 206,
                                  height: 45,
                                  borderRadius: 30,
                                  bgColor: MyColors.appTheme,
                                  textColor: Colors.white,
                                  title: "Yes",
                                  onPressed: () {
                                    // Navigator.pop(context);
                                    CustomNavigator.pushNavigate(context, DimensionAlanalysisTest());
                                    // Navigate to Test Screen here
                                  },
                                ),
                                CommonButton1(
                                  width: 206,
                                  height: 45,
                                  borderRadius: 30,
                                  title: "No, Maybe Later",
                                  bgColor: MyColors.whiteText,
                                  textColor: MyColors.appTheme,
                                  onPressed: () {
                                    Navigator.pop(context,true);
                                  },
                                ),
                              ],
                            ),

                          const SizedBox(height: 10), // optional spacing below buttons
                        ],
                      );

                    },
                  ).then((value) {
                    if(value){
                      Navigator.pop(context);
                    }
                  },);
                },
              ),

              CommonButton1(
                height: 45,
                title: "No, Exit",
                bgColor: MyColors.whiteText,
                textColor: MyColors.appTheme,
                onPressed: () {
                  Navigator.pop(context); // just close sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
