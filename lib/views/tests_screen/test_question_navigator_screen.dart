import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/provider/provider_classes/TestStartProvider.dart';
import 'package:rank_up/views/tests_screen/DimensionalAnalysis.dart';
import '../../Utils/CommonButton.dart';
import '../../models/FetchedGridStatus.dart';

class TestQuestionNavigatorScreen extends StatefulWidget {
  final int totalQuestions;

  const TestQuestionNavigatorScreen({
    super.key,
    required this.totalQuestions,
  });

  @override
  State<TestQuestionNavigatorScreen> createState() =>
      _TestQuestionNavigatorScreenState();
}

class _TestQuestionNavigatorScreenState
    extends State<TestQuestionNavigatorScreen> {
  int? selectedNumber;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StartTestProvider>(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: CommonScaffold(
        showBack: false,
        padding: false,
        backgroundColor: MyColors.appTheme,
        title: provider.formatTime(provider.remainingSeconds),
        body: Column(
          children: [
            hSized10,
            Text(
              "Current attempting question",
              style: semiBoldTextStyle(color: Colors.white, fontSize: 18),
            ),
            hSized10,
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: MyColors.rankBg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: widget.totalQuestions,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (_, index) {
                          final number = index + 1;

                          final grid = provider.gridList.firstWhere(
                                (e) => e.number == number,
                            orElse: () => Grid(status: "NOT_VISITED"),
                          );

                          final bgColor = provider.getStatusColor(grid);

                          final isSelected = selectedNumber == number;

                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                selectedNumber = number;
                              });

                              final testProvider =
                              Provider.of<StartTestProvider>(context,
                                  listen: false);

                              /// Navigate to question
                              // await Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (ctx) {
                              //       Future.microtask(() {
                              //         testProvider.fetchNextQuestion(
                              //           ctx,
                              //           number,
                              //           routing: "byNumber",
                              //         );
                              //       });
                              //       return DimensionAlanalysisTest(
                              //         title: "Question $number",
                              //         fromGrid: true,
                              //       );
                              //     },
                              //   ),
                              // );

                              /// Back → Refresh grid API
                              final attemptId = testProvider
                                  .startModel
                                  ?.data
                                  ?.attempt
                                  ?.id
                                  ?.toString() ??
                                  "";

                              // if (attemptId.isNotEmpty) {
                              //   await testProvider.fetchGridStatus(attemptId);
                              // }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: bgColor,
                                border: isSelected
                                    ? Border.all(
                                  color: Colors.white,
                                  width: 2,
                                )
                                    : null,
                              ),
                              child: Text(
                                number.toString(),
                                style: semiBoldTextStyle(
                                  color: provider.textColor(bgColor),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    CommonButton(
                      onPressed: () async {
                        final provider = Provider.of<StartTestProvider>(
                          context,
                          listen: false,
                        );

                        final number = selectedNumber ?? provider.currentQuestionNumber;

                        final attemptId =
                            provider.startModel?.data?.attempt?.id.toString() ?? "";
                        if (attemptId.isNotEmpty) {
                           provider.fetchGridStatus(attemptId);
                        }

                        // 2️⃣ Close the bottom sheet first
                        Navigator.pop(context);

                        // 3️⃣ Delay fetchNextQuestion using the **root screen context**
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (Navigator.canPop(context)) {
                            final rootContext = Navigator.of(context).context;
                            provider.fetchNextQuestion(
                              rootContext,
                              number,
                              routing: "byNumber",
                            );
                          }
                        });
                      },
                      color: MyColors.appTheme,
                      text: "Continue",
                      textColor: Colors.white,
                    ),



                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

