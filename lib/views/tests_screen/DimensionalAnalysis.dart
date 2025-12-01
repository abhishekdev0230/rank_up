import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/provider/provider_classes/TestStartProvider.dart';
import 'package:rank_up/views/FlashcardQ/DimensionalAnalysis/OptionTileWidget.dart';
import 'package:rank_up/views/Home/home_view.dart';
import 'package:rank_up/views/tests_screen/test_question_navigator_screen.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class DimensionAlanalysisTest extends StatefulWidget {
  final String title;
  final bool fromGrid;
  const DimensionAlanalysisTest({super.key,    this.fromGrid = false, required this.title});

  @override
  State<DimensionAlanalysisTest> createState() =>
      _DimensionAlanalysisTestState();
}

class _DimensionAlanalysisTestState extends State<DimensionAlanalysisTest> {
  @override
  void initState() {
    super.initState();
    if (!widget.fromGrid) {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = Provider.of<StartTestProvider>(context, listen: false);

        provider.fetchNextQuestion(context, 1);
      });

      // provider.fetchNextQuestion(context, 1);
    }


  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StartTestProvider>(context);

    final data = provider.quetionsData;

    final question = data?.question;
    final options = question?.options ?? [];

    return CommonScaffold(
      padding: false,
      showBack: true,

      actions: [
        IconButton(
          icon: const Icon(Icons.grid_view, color: Colors.white),
          onPressed: () async {

            final provider = Provider.of<StartTestProvider>(context, listen: false);

            final attemptId = provider.startModel?.data?.attempt?.id.toString() ?? "";

            if (attemptId.isNotEmpty) {
               provider.fetchGridStatus(attemptId);
            }
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.65,
                  minChildSize: 0.5,
                  maxChildSize: 0.95,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      child: TestQuestionNavigatorScreen(
                        totalQuestions: Provider.of<StartTestProvider>(
                          context,
                          listen: false,
                        ).totalQuestion,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],

      backgroundColor: MyColors.appTheme,
      title: widget.title,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          final provider = Provider.of<StartTestProvider>(context, listen: false);

          if (details.primaryVelocity! < 0) {
            provider.goToNext(context);
          }

          if (details.primaryVelocity! > 0) {
            provider.goToPrevious(context);
          }
        },

        child: Column(
          children: [
            hSized15,
            (data == null)
                ? Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height /2.7),
                    child: Center(
                      child: Text(
                        "No question available",
                        style: semiBoldTextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 6,
                          decoration: BoxDecoration(
                            color: MyColors.whiteText,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: provider.totalQuestion == 0
                                ? 0
                                : provider.currentQuestionNumber /
                                      provider.totalQuestion,

                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.color19B287,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),

                        hSized10,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Q. ${provider.currentQuestionNumber} / ${provider.totalQuestion}",
                              style: semiBoldTextStyle(color: MyColors.whiteText),
                            ),

                            Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                wSized10,
                                Text(
                                  provider.formatTime(provider.remainingSeconds),
                                  style: regularTextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        hSized20,

                        Container(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                question?.text ?? "",
                                textAlign: TextAlign.center,
                                style: semiBoldTextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),

                              hSized12,

                              // Options Grid
                              ResponsiveGridList(
                                shrinkWrap: true,
                                minItemWidth:
                                    (MediaQuery.of(context).size.width - 64) / 2,
                                minItemsPerRow: 2,
                                maxItemsPerRow: 2,
                                children: List.generate(options.length, (index) {
                                  final opt = options[index];
                                  return GestureDetector(
                                    onTap: () {
                                      provider.selectOption(index);
                                      provider.submitAnswer(
                                        context,
                                        opt.id.toString(), // option ID
                                      );
                                    },
                                    child: OptionTileWidget(
                                      opt.text ?? "",
                                      isCorrect: false,
                                      isSelected:
                                          provider.selectedOptionIndex == index,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),

                        hSized20,

                      ],
                    ),
                  ),

            const Spacer(),

            Container(
              height: 67,
              width: double.infinity,
              color: MyColors.color295176,
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton1(
                      title: "Previous",
                      height: 47,
                      bgColor: MyColors.color295176,
                      onPressed: () {
                        provider.goToPrevious(context);
                      },
                    ),
                  ),
                  wSized10,
                  Expanded(
                    child: CommonButton1(
                      title: "Next",
                      height: 47,
                      onPressed: () {
                        provider.goToNext(context);
                      },
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
