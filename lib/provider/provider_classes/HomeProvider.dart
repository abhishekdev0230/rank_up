import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  // USER INFO
  String username = "Robert Jones";

  // MODULES & PROGRESS
  double moduleProgress = 0.35; // Example: 35% progress
  int completedModules = 2;

  // QUESTION OF THE DAY
  String qotd = "What is the powerhouse of the Cell?";

  // LIVE TEST
  String liveTestTitle = "Photosynthesis & Respiration";
  String liveTestTimer = "02:35";

  // FEATURED DECKS
  int selectedIndex = -1;
  List<Map<String, dynamic>> featuredDecks = [
    {"title": "NEET Prep Biology", "color": 0xFFFF5F37},
    {"title": "High-Yield Chemistry", "color": 0xFF2DB552},
    {"title": "Physics Formulas", "color": 0xFF375EC2},
    {"title": "Exam Focused", "color": 0xFFD77937},
  ];

  // QUIZ SECTION
  String quizTitle = "A - Z";
  String quizDescription =
      "Collection of frequently and repeatedly asked topics from all Flashcards";

  // ------------------ METHODS TO UPDATE DATA ------------------

  void setUsername(String name) {
    username = name;
    notifyListeners();
  }

  void updateModuleProgress(double value) {
    moduleProgress = value;
    notifyListeners();
  }

  void updateCompletedModules(int value) {
    completedModules = value;
    notifyListeners();
  }

  void setQOTD(String question) {
    qotd = question;
    notifyListeners();
  }

  void setLiveTest(String title, String timer) {
    liveTestTitle = title;
    liveTestTimer = timer;
    notifyListeners();
  }
}
