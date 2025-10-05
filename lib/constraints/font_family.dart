import 'package:flutter/material.dart';

///:::::::::::::::: Font Families ::::::::::::::::
class FontFamilies {
  static const outfitBold = "OutfitBold";
  static const outfitSemiBold = "OutfitSemiBold";
  static const outfitRegular = "OutfitRegular";
  static const outfitLight = "OutfitLight";
  static const outfitMedium = "OutfitMedium";
  static const outfitExtraBold = "OutfitExtraBold";
}

///:::::::::::::::: App Padding ::::::::::::::::
class AppPadding {
  static const double horizontal = 15.0;
  static const double vertical = 15.0;
}

///:::::::::::::::: MediaQuery Helpers ::::::::::::::::
extension MediaQueryHelper on BuildContext {
  /// Width percentage: pass 0.0 to 1.0
  double wp(double percent) => MediaQuery.of(this).size.width * percent;

  /// Height percentage: pass 0.0 to 1.0
  double hp(double percent) => MediaQuery.of(this).size.height * percent;
}
