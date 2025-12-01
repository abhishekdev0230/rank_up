import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/views/Home/home_view.dart';

class QuizCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final VoidCallback onTap;

  const QuizCardWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.color295176,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath),
          Text(
            textAlign: TextAlign.center,
            title,
            style: semiBoldTextStyle(color: MyColors.whiteText, fontSize: 32),
          ),
          Text(
            subtitle,
            style: regularTextStyle(color: MyColors.whiteText, fontSize: 14),
          ),
          hSized15,
          CommonButton1(

              width:100,
              title: "Take Quiz", onPressed: onTap),
        ],
      ),
    );
  }
}
