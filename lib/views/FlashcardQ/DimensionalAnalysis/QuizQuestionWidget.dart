import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/models/StartQuizModel.dart';
import 'package:rank_up/provider/provider_classes/QuizAnswerProvider.dart';
import 'package:rank_up/views/Home/home_view.dart';
import '../../../Utils/helper.dart';
import 'OptionTileWidget.dart';

class QuizQuestionWidget extends StatefulWidget {
  final Question question;
  final int currentIndex;
  final int totalQuestions;
  final String attemptId;
  final int duration;
  final String? selectedOptionId;
  final bool? isCorrect;
  final Function(String optionId) onSelectOption;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLastQuestion;

  const QuizQuestionWidget({
    super.key,
    required this.question,
    required this.currentIndex,
    required this.totalQuestions,
    required this.duration,
    required this.onNext,
    required this.onPrevious,
    required this.onSelectOption,
    this.selectedOptionId,
    this.isCorrect = false,
    this.isLastQuestion = false,
    required this.attemptId,
  });

  @override
  State<QuizQuestionWidget> createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {
  late Timer _timer;
  late int _remainingSeconds;
  bool _previousPressed = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.duration * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  String get formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizAnswerProvider = Provider.of<QuizAnswerProvider>(context);
    final selectedAnswer = quizAnswerProvider.getSelectedAnswer(
      widget.question.id ?? "",
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          hSized20,
          // 🔹 Progress Bar
          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: MyColors.whiteText,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (widget.currentIndex + 1) / widget.totalQuestions,
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.color19B287,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          hSized10,
          // 🔹 Question info with timer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Q. ${widget.currentIndex + 1}/${widget.totalQuestions}",
                style: semiBoldTextStyle(color: MyColors.whiteText),
              ),
              Row(
                children: [
                  const Icon(Icons.timer, color: Colors.white, size: 18),
                  const SizedBox(width: 5),
                  Text(
                    formattedTime,
                    style: regularTextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          hSized30,
          // 🔹 Question Card
          GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                widget.onNext();
                setState(() => _previousPressed = false);
              } else if (details.primaryVelocity! > 0) {
                if (!_previousPressed) {
                  widget.onPrevious();
                  setState(() => _previousPressed = true);
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.question.questionText ?? "No question text",
                      textAlign: TextAlign.center,
                      style: semiBoldTextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  hSized20,
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      for (var opt in widget.question.options ?? [])
                        GestureDetector(
                          onTap: () async {
                            final selectedId = opt.id ?? '';
                            if (selectedAnswer == null) {
                              widget.onSelectOption(selectedId);
                              await quizAnswerProvider.submitAnswer(
                                context: context,
                                attemptId: widget.attemptId,
                                questionId: widget.question.id ?? "",
                                optionId: selectedId,
                                selectedAnswer: opt.optionLabel ?? "",
                                timeTaken:
                                    widget.duration * 60 - _remainingSeconds,
                              );
                              setState(() {});
                            } else {
                              Helper.customToast(
                                "You cannot change your answer",
                              );
                            }
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 64) / 2,
                            constraints: const BoxConstraints(minHeight: 55),
                            child: OptionTileWidget(
                              "${opt.optionLabel}. ${opt.optionText}",
                              isSelected: selectedAnswer == opt.id,
                              isCorrect:
                                  selectedAnswer == opt.id &&
                                  quizAnswerProvider
                                          .quizAnsModel
                                          ?.data
                                          ?.isCorrect ==
                                      true,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (selectedAnswer != null) ...[
            hSized20,
            Consumer<QuizAnswerProvider>(
              builder: (context, ansProvider, _) {
                final ansData = ansProvider.quizAnsModel?.data;
                if (ansData == null || _previousPressed == true)
                  return SizedBox.shrink();

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Detailed Explanation",
                            style: semiBoldTextStyle(fontSize: 16),
                          ),
                          hSized10,
                          Text(
                            "Correct Answers: ${ansData?.correctAnswer ?? ''}",
                            style: semiBoldTextStyle(
                              color: ansData?.isCorrect == true
                                  ? MyColors.color19B287
                                  : MyColors.colorFF0000,
                              fontSize: 14,
                            ),
                          ),
                          hSized10,
                          Text(
                            ansData?.explanation ?? "",
                            style: regularTextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    hSized20,
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: ansData?.isCorrect == true
                            ? MyColors.color19B287
                            : MyColors.colorFF0000,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        ansData?.isCorrect == true
                            ? "Correct Answer"
                            : "Incorrect Answer",
                        style: semiBoldTextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
          SizedBox(height: context.wp(1 / 4.7)),
          // 🔹 Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.currentIndex > 0)
                Expanded(
                  child: CommonButton1(
                    height: 47,
                    bgColor: MyColors.color295176,
                    title: "Previous",
                    onPressed: _previousPressed
                        ? null
                        : () {
                            widget.onPrevious();
                            setState(() => _previousPressed = true);
                          },
                  ),
                ),
              if (widget.currentIndex > 0) wSized10,
              Expanded(
                child: CommonButton1(
                  height: 47,
                  title: widget.isLastQuestion ? "Finish" : "Next",
                  onPressed: () {
                    widget.onNext();
                    setState(() => _previousPressed = false);
                  },
                ),
              ),
            ],
          ),
          hSized15,
        ],
      ),
    );
  }
}
