import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';

class OptionTileWidget extends StatelessWidget {
  final String text;
  final bool isCorrect;
  final bool isSelected;

  const OptionTileWidget(
    this.text, {
    super.key,
    required this.isCorrect,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = isSelected
        ? (isCorrect ? MyColors.color19B287 : MyColors.colorFF0000)
        : MyColors.appTheme;

    Color textColor = isSelected
        ? (isCorrect ? MyColors.color19B287 : MyColors.colorFF0000)
        : MyColors.appTheme;

    return Stack(
      children: [
        Container(
          height: 100,
          alignment: Alignment.center,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Text(
            maxLines: 3,
            text,
            style: mediumTextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
        ),
        if (isSelected && isCorrect)
          const Positioned(
            top: 0,
            right: 0,
            child: Icon(
              Icons.check_circle,
              color: MyColors.color19B287,
              size: 22,
            ),
          ),
      ],
    );
  }
}
