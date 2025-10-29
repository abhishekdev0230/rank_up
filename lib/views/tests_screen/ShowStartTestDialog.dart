import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';

import '../Home/home_view.dart';
import 'ShowInstructionDialog.dart';

class GrandTestShowInstructionDialog {
  static void show(BuildContext context) {
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
              hSized30,
              SvgPicture.asset(IconsPath.grandTestImage),
              hSized24,
              // Title
              Text(
                "Grand Test 1 - INICET PATTERN",
                textAlign: TextAlign.center,
                style: semiBoldTextStyle(
                  fontSize: 18,
                  color: MyColors.blackColor,
                ),
              ),
              hSized15,
              // Small line under title
              Container(width: 50, height: 2, color: MyColors.color949494),
              hSized15,
              // Description
              Text(
                "This Grand test contains 10 MCQ from various subjects with a duration of 20 minutes",
                textAlign: TextAlign.center,
                style: regularTextStyle(
                  fontSize: 14,
                  color: MyColors.color949494,
                ),
              ),
              hSized24,
              // START TEST button
              SizedBox(
                width: double.infinity,
                child: CommonButton1(
                  height: 48,
                  title: "START TEST",
                  bgColor: MyColors.appTheme,
                  textColor: Colors.white,
                  borderRadius: 25,
                  onPressed: () {
                    Navigator.pop(context);
                    ShowInstructionDialog.showDetailedInstructions(context);
                    // Navigate to test screen if needed
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => TestScreen()));
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Note Description
              Text(
                "Note: Answer of the questions marked for review at the time of submission will not be considered in the final evaluation. This rule is based on the current INICET guidelines.",
                textAlign: TextAlign.center,
                style: regularTextStyle(
                  fontSize: 12,
                  color: MyColors.color949494,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
