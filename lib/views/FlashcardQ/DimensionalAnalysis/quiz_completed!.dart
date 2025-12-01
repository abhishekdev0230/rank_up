import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/constraints/font_family.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/provider/provider_classes/quiz_complete_provider.dart';
import 'package:rank_up/views/FlashcardQ/DimensionalAnalysis/review_screen.dart';
import 'package:rank_up/views/Home/home_view.dart';
import 'package:rank_up/views/bottom_navigation_bar.dart';

import '../../onboarding_screen/onboarding_screen.dart';

class QuizCompletedWidget extends StatefulWidget {
  final String attemptId;

  const QuizCompletedWidget({super.key, required this.attemptId});

  @override
  State<QuizCompletedWidget> createState() => _QuizCompletedWidgetState();
}

class _QuizCompletedWidgetState extends State<QuizCompletedWidget> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizCompleteProvider>(context, listen: false)
          .fetchQuizComplete(context, widget.attemptId);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<QuizCompleteProvider>(
      builder: (context, provider, _) {
        final data = provider.completeModel?.data;


        if (data == null) {
          return const Center(child: Text("No Data Found"));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSized20,

              /// TITLE
              Text(
                data.quizTitle ?? "Quiz Completed!",
                style: semiBoldTextStyle(color: Colors.white, fontSize: 20),
              ),

              hSized20,

              /// MAIN CARD
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MyColors.rankBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "You solved ${data.totalQuestions ?? 0} MCQs",
                      style: mediumTextStyle(fontSize: 16),
                    ),

                    hSized20,

                    /// CIRCLE PROGRESS
                    SizedBox(
                      height: 170,
                      width: 170,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(170, 170),
                            painter: RoundedCircularProgressPainter(
                              progress: (data.percentage ?? 0) / 100,
                              color: MyColors.color19B287,
                              backgroundColor: MyColors.whiteText,
                              strokeWidth: 10,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${data.percentage?.toStringAsFixed(0)}%",
                                style: semiBoldTextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                textAlign: TextAlign.center,
                                data.isPassed == true
                                    ? "Great Job!"
                                    : "Try Again!",
                                style: regularTextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    hSized24,

                    /// CORRECT / INCORRECT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.green, size: 5),
                            wSized5,
                            Text(
                              "${data.correctAnswers} Correct",
                              style: mediumTextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.circle, color: Colors.red, size: 5),
                            wSized5,
                            Text(
                              "${data.incorrectAnswers} Incorrect",
                              style: mediumTextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    hSized20,

                    /// TIME TAKEN + ATTEMPTS
                    Row(
                      children: [
                        Text(
                          "Time Taken: ",
                          style: regularTextStyle(color: Colors.black, fontSize: 13),
                        ),
                        Text(
                          "${data.timeTaken} sec",
                          style: regularTextStyle(color: Colors.black, fontSize: 13),
                        ),
                        Spacer(),
                        Text(
                          "Attempted:",
                          style: regularTextStyle(color: Colors.black, fontSize: 13),
                        ),
                        Text(
                          "${data.attemptedQuestions}/${data.totalQuestions}",
                          style: regularTextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),

                    hSized40,

                    /// REVIEW + BACK
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton1(
                            title: "Review Answer",
                            height: 47,
                            bgColor: MyColors.color19B287,
                            onPressed: () {
                              pushScreen(
                                context,
                                screen: ReviewScreen(attemptId: widget.attemptId),
                                withNavBar: false,
                              );
                            },
                          ),
                        ),

                        wSized10,
                        Expanded(
                          child: CommonButton1(
                            title: "Back to Home",
                            height: 47,
                            bgColor: MyColors.appTheme,
                            onPressed: () {
                              pushScreen(
                                context,
                                screen: const BottomNavController(initialIndex: 0),
                                withNavBar: false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              hSized30,

              /// SUMMARY ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Questions: ${data.totalQuestions}",
                      style: regularTextStyle(color: Colors.white, fontSize: 13)),
                  Text("Correct: ${data.correctAnswers}",
                      style: regularTextStyle(color: Colors.white, fontSize: 13)),
                  Text("Incorrect: ${data.incorrectAnswers}",
                      style: regularTextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
              hSized10,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Bookmarked: 0",
                      style: regularTextStyle(color: Colors.white, fontSize: 13)),
                  Text("Schema MCQs: 0",
                      style: regularTextStyle(color: Colors.white)),
                ],
              ),

              hSized15,

              /// BACK BUTTON
              // Center(
              //   child: CommonButton1(
              //     width: 150,
              //     title: "<<< Back to Home",
              //     height: 35,
              //     textColor: Colors.black,
              //     bgColor: MyColors.rankBg,
              //     onPressed: () {
              //       pushScreen(
              //         context,
              //         screen: const BottomNavController(initialIndex: 0),
              //         withNavBar: false,
              //       );
              //     },
              //   ),
              // ),
              // hSized24,
            ],
          ),
        );
      },
    );
  }
}

