import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';

class FlashcardOrQuizTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;

  const FlashcardOrQuizTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
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
        children: [
          SvgPicture.asset(iconPath),
          Text(title,
              style: semiBoldTextStyle(color: MyColors.whiteText, fontSize: 32)),
          Text(subtitle,
              style: regularTextStyle(color: MyColors.whiteText, fontSize: 14)),
        ],
      ),
    );
  }
}
