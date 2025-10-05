import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Widget? iconLeft;
  final Widget? iconRight;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? fontSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const CommonButton({
    super.key,
    required this.text,
    this.iconLeft,
    this.iconRight,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderColor,
    this.height,
    this.fontSize,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 48,
        decoration: BoxDecoration(
          color: color ?? MyColors.appTheme,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconLeft != null) ...[iconLeft!, const SizedBox(width: 8)],
              Text(
                text,
                style: semiBoldTextStyle(
                  fontSize: fontSize ?? 15,
                  color: textColor ?? Colors.white,
                ),
              ),
              if (iconRight != null) ...[const SizedBox(width: 8), iconRight!],
            ],
          ),
        ),
      ),
    );
  }
}


