import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/views/FlashcardQ/DimensionalAnalysis/quiz_completed!.dart';

import '../../../constraints/icon_path.dart';
import '../NeetPYQsFlashcardsInner.dart';
import 'FlashcardOrQuizTile.dart';
import 'QuizCardWidget.dart';
import 'QuizQuestionWidget.dart';

class DimensionalAnalysis extends StatefulWidget {
  final String type;
  const DimensionalAnalysis({super.key, required this.type});

  @override
  State<DimensionalAnalysis> createState() => _DimensionalAnalysisState();
}

class _DimensionalAnalysisState extends State<DimensionalAnalysis> {
  bool isCorrect = false;
  bool startQuiz = false;
  bool showCompleted = false; // 👈 new variable

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: MyColors.appTheme,
      title: "Dimensional Analysis",
      body: widget.type == "TackQuiz"
          ? (startQuiz
          ? (showCompleted
          ? const QuizCompletedWidget()
          : QuizQuestionWidget(
        isCorrect: isCorrect,
        onToggleAnswer: () {
          setState(() {
            isCorrect = !isCorrect;
            showCompleted = true;
          });
        },
      ))
          : Column(
        children: [
          hSized20,
          QuizCardWidget(
            title: "Quiz 1",
            subtitle: "2 Quizzes | 20 Total Questions",
            iconPath: IconsPath.flashcardsIcon,
            onTap: () => setState(() => startQuiz = true),
          ),
          hSized20,
          QuizCardWidget(
            title: "Quiz 2",
            subtitle: "2 Quizzes | 20 Total Questions",
            iconPath: IconsPath.quizIcon,
            onTap: () => setState(() => startQuiz = true),
          ),
        ],
      ))
          : Column(
        children: [
          hSized20,
          GestureDetector(
            onTap: () {
              pushScreen(
                context,
                screen: NeetPYQsFlashcardsInner(),
                withNavBar: true,
                pageTransitionAnimation:
                PageTransitionAnimation.cupertino,
              );
            },
            child: FlashcardOrQuizTile(
              title: "Flashcards",
              subtitle: "30 Total Flashcards",
              iconPath: IconsPath.flashcardsIcon,
            ),
          ),
          hSized20,
          FlashcardOrQuizTile(
            title: "Quiz",
            subtitle: "2 Quizzes | 20 Total Questions",
            iconPath: IconsPath.quizIcon,
          ),
        ],
      ),
    );
  }
}

