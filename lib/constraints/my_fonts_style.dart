import 'package:flutter/material.dart';
import 'font_family.dart';

TextStyle lightTextStyle({
  required double fontSize,
  required Color color,
  double? letterSpacing,
  double? height,
  TextOverflow? overflow,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    letterSpacing: letterSpacing,
    height: height,
    overflow: overflow,
    fontFamily: FontFamilies.outfitLight,
  );
}

  TextStyle regularTextStyle({
   double? fontSize,
  required Color color,
  double? height,
  double? wordSpacing,
  TextOverflow? overflow,
}) {
  return TextStyle(
    wordSpacing: wordSpacing,
    fontSize: fontSize,
    color: color,
    height: height,
    overflow: overflow,
    fontFamily: FontFamilies.outfitRegular,
  );
}

TextStyle semiBoldTextStyle({
   double? fontSize,
   Color? color,
  double? height,
  TextOverflow? overflow,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    height: height,
    overflow: overflow,
    fontFamily: FontFamilies.outfitSemiBold,
  );
}
TextStyle mediumTextStyle({
   double? fontSize,
   Color? color,
  double? height,
  TextOverflow? overflow,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    height: height,
    overflow: overflow,
    fontFamily: FontFamilies.outfitMedium,
  );
}

TextStyle boldTextStyle({
  required double fontSize,
   Color? color,
  double? height,
  double? letterSpacing,
  TextOverflow? overflow,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    height: height,
    overflow: overflow,
    fontFamily: FontFamilies.outfitBold,
  );
}
