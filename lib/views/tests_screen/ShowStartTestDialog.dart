import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/models/TestResumeBottomModel.dart';

import '../Home/home_view.dart';
import 'ShowInstructionDialog.dart';

class GrandTestShowInstructionDialog {
  static void show(BuildContext context, TestResumeBottom test,String testId,String title) {
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

              // 🔥 API Title
              Text(
                test.title ?? "Test",
                textAlign: TextAlign.center,
                style: semiBoldTextStyle(
                  fontSize: 18,
                  color: MyColors.blackColor,
                ),
              ),

              hSized15,
              Container(width: 50, height: 2, color: MyColors.color949494),
              hSized15,

              // 🔥 API Description
              Text(
                test.description ??
                    "No description available.",
                textAlign: TextAlign.center,
                style: regularTextStyle(
                  fontSize: 14,
                  color: MyColors.color949494,
                ),
              ),

              hSized15,

              // 🔥 Questions + Duration
              Text(
                "${test.totalQuestions ?? 0} MCQs • ${test.duration ?? 0} minutes",
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
                    ShowInstructionDialog.showDetailedInstructions(context,testId,title,false);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Note
              Text(
                test.instructions ?? "",
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

