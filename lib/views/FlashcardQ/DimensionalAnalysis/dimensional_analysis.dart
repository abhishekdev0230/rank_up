import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/models/QuizTopicOptionModel.dart';
import 'package:rank_up/provider/provider_classes/QuizTopicOptionProvider.dart';
import 'package:rank_up/provider/provider_classes/StartQuizProvider.dart';
import 'package:rank_up/views/FlashcardQ/DimensionalAnalysis/quiz_completed!.dart';

import '../../../constraints/icon_path.dart';
import '../../../provider/provider_classes/QuizAnswerProvider.dart';
import '../NeetPYQsFlashcardsInner.dart';
import 'FlashcardOrQuizTile.dart';
import 'QuizCardWidget.dart';
import 'QuizQuestionWidget.dart';

class DimensionalAnalysis extends StatefulWidget {
  final String title;
  final String type;
  final String totalFlashcards;
  final String totalQuizzes;
  final String totalQuestions;
  final String topicId;

  const DimensionalAnalysis({
    super.key,
    required this.title,
    required this.type,
    required this.totalFlashcards,
    required this.topicId,
    required this.totalQuizzes,
    required this.totalQuestions,
  });

  @override
  State<DimensionalAnalysis> createState() => _DimensionalAnalysisState();
}

class _DimensionalAnalysisState extends State<DimensionalAnalysis> {
  bool isCorrect = false;
  bool startQuiz = false;
  bool showCompleted = false;
  int currentQuestionIndex = 0;
  String? selectedOptionId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<QuizTopicOptionProvider>(
        context,
        listen: false,
      ).fetchQuizTopics(context, widget.topicId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizAnswerProvider = Provider.of<QuizAnswerProvider>(context, listen: false);
    // final questions = startQuizProvider.startQuizModel?.data?.questions ?? [];
    // final currentQuestion = questions[currentQuestionIndex];
    return CommonScaffold(
      backgroundColor: MyColors.appTheme,
      title: widget.title,
      body: widget.type == "TackQuiz"
          ? Consumer<QuizTopicOptionProvider>(
              builder: (context, quizProvider, _) {
                final startQuizProvider = Provider.of<QuizStartProvider>(
                  context,
                  listen: false,
                );
                if (startQuiz) {
                  if (showCompleted) {
                    return QuizCompletedWidget(
                      timeTaken: QuizAnswerProvider.totalTimeUsed1.toString(),
                      attemptId:
                          startQuizProvider
                              .startQuizModel
                              ?.data!
                              .questions
                              ?.first
                              .attemptId
                              .toString() ??
                          "",
                    );
                  }

                  final questions =
                      startQuizProvider.startQuizModel?.data?.questions ?? [];

                  if (questions.isEmpty) {
                    return const Center(
                      child: Text(
                        "No questions available",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  final currentQuestion = questions[currentQuestionIndex];

                  return QuizQuestionWidget(
                    attemptId: currentQuestion.attemptId.toString(),
                    question: currentQuestion,
                    currentIndex: currentQuestionIndex,
                    totalQuestions: questions.length,
                    duration: startQuizProvider.startQuizModel?.data?.duration ?? 15,
                    selectedOptionId: quizAnswerProvider.getSelectedAnswer(currentQuestion.id ?? ""),
                    onSelectOption: (id) {
                      final selected = quizAnswerProvider.getSelectedAnswer(currentQuestion.id ?? "");
                      if (selected == null) {
                        setState(() {
                          selectedOptionId = id;
                        });
                      } else {
                        Helper.customToast("You cannot change your answer");
                      }
                    },
                    onNext: () {
                      final selected = quizAnswerProvider.getSelectedAnswer(currentQuestion.id ?? "");
                      if (selected == null) {
                        Helper.customToast("Please select an option to proceed");
                        return;
                      }

                      if (currentQuestionIndex < questions.length - 1) {
                        setState(() {
                          currentQuestionIndex++;
                          selectedOptionId = null;
                        });
                      } else {
                        setState(() {
                          showCompleted = true;
                        });
                      }
                    },
                    onPrevious: () {
                      if (currentQuestionIndex > 0) {
                        setState(() {
                          currentQuestionIndex--;
                          selectedOptionId = null;
                        });
                      }
                    },
                  );
                }

                if (quizProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (quizProvider.quizModel?.data == null ||
                    quizProvider.quizModel!.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No quizzes available",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final quizData = quizProvider.quizModel!.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var quiz in quizData)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: QuizCardWidget(
                            title: quiz.title ?? "Untitled Quiz",
                            subtitle:
                                "${quiz.totalQuestions ?? 0} Questions | ${quiz.duration ?? 0} mins | ${quiz.attemptCount ?? 0} Attempts",
                            iconPath: IconsPath.quizIcon,
                            onTap: () async {
                              final quizStartProvider =
                                  Provider.of<QuizStartProvider>(
                                    context,
                                    listen: false,
                                  );

                              // 🔹 Start quiz API call
                              await quizStartProvider.startQuiz(
                                context,
                                quiz.id ?? "",
                              );

                              final startQuizData =
                                  quizStartProvider.startQuizModel?.data;

                              if (startQuizData == null) {
                                Helper.customToast(
                                  "Something went wrong. Please try again.",
                                );
                                return;
                              }

                              final questions = startQuizData.questions ?? [];

                              if (questions.isNotEmpty) {
                                setState(() {
                                  startQuiz = true;
                                  currentQuestionIndex = 0;
                                  selectedOptionId = null;
                                });
                              } else {
                                // 🔹 Handle "Quiz already started" gracefully
                                if (quizStartProvider.startQuizModel?.message ==
                                    "Quiz has already been started") {
                                  Helper.customToast(
                                    "Resuming your previous quiz...",
                                  );
                                  setState(() {
                                    startQuiz = true;
                                    currentQuestionIndex = 0;
                                    selectedOptionId = null;
                                  });
                                } else {
                                  Helper.customToast(
                                    "No questions found for this quiz",
                                  );
                                }
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                );
              },
            )
          : Column(
              children: [
                hSized20,
                GestureDetector(
                  onTap: () {
                    pushScreen(
                      context,
                      screen: NeetPYQsFlashcardsInner(topicId: widget.topicId),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: FlashcardOrQuizTile(
                    title: "Flashcards",
                    subtitle: "${widget.totalFlashcards} Total Flashcards",
                    iconPath: IconsPath.flashcardsIcon,
                  ),
                ),
                hSized20,
                GestureDetector(
                  onTap: () {
                    pushScreen(
                      context,
                      screen: DimensionalAnalysis(
                        title: widget.title,
                        type: "TackQuiz",
                        totalFlashcards: widget.totalFlashcards,
                        totalQuizzes: widget.totalQuizzes,
                        totalQuestions: widget.totalQuestions,
                        topicId: widget.topicId,
                      ),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: FlashcardOrQuizTile(
                    title: "Quiz",
                    subtitle:
                        "${widget.totalQuizzes} Quizzes | ${widget.totalQuestions} Total Questions",
                    iconPath: IconsPath.quizIcon,
                  ),
                ),
              ],
            ),
    );
  }
}
