import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/views/FlashcardQ/classIn_study_all_flashcards.dart';

class FlashcardInnerPhysicsScreen extends StatefulWidget {
  const FlashcardInnerPhysicsScreen({super.key});

  @override
  State<FlashcardInnerPhysicsScreen> createState() =>
      _FlashcardInnerPhysicsScreenState();
}

class _FlashcardInnerPhysicsScreenState
    extends State<FlashcardInnerPhysicsScreen> {
  int selectedTab = 0;

  final List<String> tabs = ["Class 11", "Class 12", "Achiever"];

  // ---------------- Topics List ----------------
  final List<Map<String, dynamic>> topics = [
    {
      "title": "Units & Measurements",
      "subtitle": "50 Flashcards | 2 Quizzes",
      "icon": Icons.biotech_rounded,
    },
    {
      "title": "Kinematics",
      "subtitle": "20 Flashcards | 2 Quizzes",
      "icon": Icons.science_rounded,
    },
    {
      "title": "Laws of Motion",
      "subtitle": "30 Flashcards | 2 Quizzes",
      "icon": Icons.ac_unit_rounded,
    },
    {
      "title": "Work Energy & Power",
      "subtitle": "25 Flashcards | 2 Quizzes",
      "icon": Icons.electric_bolt_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Flashcards",
      showBack: true,
      backgroundColor: MyColors.appTheme,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hSized20,

          /// ---------------- Tabs ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(tabs.length, (index) {
              final bool isSelected = selectedTab == index;
              return GestureDetector(
                onTap: () => setState(() => selectedTab = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? MyColors.green
                        : MyColors.color295176,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tabs[index],
                    style: mediumTextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 28),

          /// ---------------- Topics Header ----------------
          Text(
            "${tabs[selectedTab]} Topics",
            style: semiBoldTextStyle(
              color: Colors.white,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 16),

          /// ---------------- Topics List ----------------
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(topics.length, (index) {
                  final topic = topics[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        CustomNavigator.pushNavigate(
                          context,
                          ClassStudyFlashcardsScreen(type: topic["title"]),
                        );
                      },
                      child: _subjectCard(
                        title: topic["title"],
                        subtitle: topic["subtitle"],
                        icon: topic["icon"],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- Subject Card ----------------
  Widget _subjectCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.color295176,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 28),
              wSized5,
              Expanded(
                child: Text(
                  title,
                  style: semiBoldTextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: regularTextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
