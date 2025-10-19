import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';

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
    Color borderColor = isCorrect
        ? MyColors.color19B287
        : isSelected
        ? MyColors.colorFF0000
        : MyColors.appTheme;

    Color textColor = isCorrect
        ? MyColors.color19B287
        : isSelected
        ? MyColors.colorFF0000
        : MyColors.appTheme;

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}
