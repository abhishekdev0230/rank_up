import 'package:flutter/cupertino.dart';

///....................StoryProvider.............

class StoryProvider with ChangeNotifier {
  double _offsetY = 0.0;

  double get offsetY => _offsetY;

  void updateOffset(double delta) {
    _offsetY += delta;
    notifyListeners();
  }

  void resetOffset() {
    _offsetY = 0;
    notifyListeners();
  }
}
