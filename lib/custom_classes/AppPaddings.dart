import 'package:flutter/material.dart';

/// Central place to manage consistent padding & spacing across the app.
class AppPaddings {
  /// Default horizontal padding used across screens (e.g. CommonScaffold)
  static const double symmetricHorizontal = 10.0;

  /// Common vertical padding for sections
  static const double sectionVertical = 16.0;

  /// Default screen-level padding (EdgeInsets)
  static const EdgeInsets screenPadding =
  EdgeInsets.symmetric(horizontal: symmetricHorizontal, vertical: sectionVertical);
}
