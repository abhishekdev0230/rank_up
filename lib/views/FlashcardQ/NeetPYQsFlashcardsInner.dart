import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/provider/provider_classes/FlashcardsQuestionsProvider.dart';
import 'package:rank_up/views/Home/home_view.dart';
import 'FlashcardCompletionScreen.dart';

class NeetPYQsFlashcardsInner extends StatefulWidget {
  final String topicId;

  const NeetPYQsFlashcardsInner({super.key, required this.topicId});

  @override
  State<NeetPYQsFlashcardsInner> createState() =>
      _NeetPYQsFlashcardsInnerState();
}

class _NeetPYQsFlashcardsInnerState extends State<NeetPYQsFlashcardsInner> {
  bool _showAnswer = false;
  bool _isSwipeLocked = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FlashcardsQuestionsProvider>().fetchTopics(
        context,
        widget.topicId,
      );
    });
  }
  Widget _buildNoDataView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Example: an illustration or icon
            Icon(
              Icons.folder_open,
              size: 80,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 20),
            Text(
              "No flashcards found 😕",
              style: regularTextStyle(
                color: Colors.grey.shade600,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              "Try again later or select a different topic.",
              style: regularTextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<FlashcardsQuestionsProvider>().fetchTopics(
                  context,
                  widget.topicId,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.color1BB287,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Retry", style: semiBoldTextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsQuestionsProvider>(
      builder: (context, provider, _) {
        return CommonScaffold(
          backgroundColor: MyColors.appTheme,
          title: provider.flashcardModel?.data?.topicName ?? "Neet PYQs",
          body: provider.currentCard == null
              ? _buildNoDataView()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      hSized20,
                      GestureDetector(
                        onTap: () {
                          if (!_showAnswer) {
                            setState(() => _showAnswer = true);
                          }
                        },

                        onPanStart: (_) {
                          _isSwipeLocked = false;
                        },

                        onPanEnd: (_) {
                          _isSwipeLocked = false;
                        },

                        onPanUpdate: (details) async {
                          if (_isSwipeLocked) return;

                          final totalCards = provider.flashcardModel?.data?.flashcards?.length ?? 0;

                          if (details.delta.dx > 15) {
                            _isSwipeLocked = true;

                            if (provider.currentIndex > 0) {
                              provider.prevCard();
                              setState(() => _showAnswer = false);
                            }
                          }

                          if (details.delta.dx < -15) {
                            _isSwipeLocked = true;

                            if (provider.currentIndex + 1 >= totalCards) {
                              CustomNavigator.pushRemoveUntil(
                                context,
                                FlashcardCompletionScreen(topicId: widget.topicId),
                              );
                            } else {
                              await provider.nextCard(context, widget.topicId);
                              setState(() => _showAnswer = false);
                            }
                          }
                        },




                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: MyColors.rankBg,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: _showAnswer
                                ? _buildAnswerCard(provider)
                                : _buildQuestionCard(provider),
                          ),
                        ),
                      ),
                      hSized30,
                      if (_showAnswer)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (provider.currentCard?.confidence == 0) {
                                  await provider
                                      .flashcardsTopicsQuetionsprogress(
                                        flashcardId:
                                            provider.currentCard?.id
                                                .toString() ??
                                            '',
                                        context: context,
                                        confidenceLevel: 1,
                                      );
                                } else {
                                  Helper.customToast(
                                    "You’ve already marked this card.",
                                  );
                                }
                              },
                              child: _circularButton(
                                "Don’t\nKnow",
                                MyColors.color1BB287,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (provider.currentCard?.confidence == 0) {
                                  await provider
                                      .flashcardsTopicsQuetionsprogress(
                                        flashcardId:
                                            provider.currentCard?.id
                                                .toString() ??
                                            '',
                                        context: context,
                                        confidenceLevel: 2, // Suspend
                                      );
                                } else {
                                  Helper.customToast(
                                    "You’ve already marked this card.",
                                  );
                                }
                              },
                              child: _circularButton(
                                "Suspend",
                                MyColors.colorF8CB52,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (provider.currentCard?.confidence == 0) {
                                  await provider
                                      .flashcardsTopicsQuetionsprogress(
                                        flashcardId:
                                            provider.currentCard?.id
                                                .toString() ??
                                            '',
                                        context: context,
                                        confidenceLevel: 3, // Know
                                      );
                                } else {
                                  Helper.customToast(
                                    "You’ve already marked this card.",
                                  );
                                }
                              },
                              child: _circularButton(
                                "Know",
                                MyColors.colorD84B48,
                              ),
                            ),
                          ],
                        ),
                      hSized15,
                    ],
                  ),
                ),
        );
      },
    );
  }

  // ---------- Question Card ----------
  Widget _buildQuestionCard(FlashcardsQuestionsProvider provider) {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SvgPicture.asset(IconsPath.woldCupIcon, height: 30),
        ),
        Container(
          alignment: Alignment.center,
          height: 230,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Q: ${provider.currentCard?.question ?? 'No question available'}",
            style: semiBoldTextStyle(color: MyColors.blackColor, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${provider.currentIndex + 1}/${provider.flashcardModel?.data?.totalFlashcards ?? 0} Flashcards in Deck",
              style: regularTextStyle(color: MyColors.blackColor, fontSize: 14),
            ),
            hSized10,
            CommonButton(
              borderRadius: 8,
              title: "Reveal answer",
              onPressed: () {
                setState(() => _showAnswer = true);
              },
            ),
          ],
        ),
      ],
    );
  }

  ///............bookMark.............
  // ---------- Answer Card ----------
  Widget _buildAnswerCard(FlashcardsQuestionsProvider provider) {
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(IconsPath.woldCupIcon, height: 38),
            const Spacer(),
            GestureDetector(
              onTap: (provider.currentCard?.isBookmarked == true ||
                  provider.isBookmarked(provider.currentCard?.id ?? ''))
                  ? null
                  : () {
                provider.bookmarkAdd(
                  contentId: provider.currentCard?.id.toString() ?? '',
                  context: context,
                );
              },
              child: SvgPicture.asset(
                provider.currentCard?.isBookmarked == true ||
                    provider.isBookmarked(provider.currentCard?.id ?? '')
                    ? IconsPath.bookmarktrueCards
                    : IconsPath.bokMarkSave,
                height: 27,

              ),
            ),


          ],
        ),
        hSized8,
        Text(
          provider.flashcardModel?.data?.topicName ?? '',
          style: semiBoldTextStyle(color: MyColors.blackColor, fontSize: 20),
        ),
        Text(
          "Card ${provider.currentIndex + 1}/${provider.flashcardModel?.data?.totalFlashcards ?? 0}",
          style: regularTextStyle(color: MyColors.color949494, fontSize: 16),
        ),
        hSized10,
        Text(
          "Q: ${provider.currentCard?.question ?? ''}",
          style: semiBoldTextStyle(color: MyColors.blackColor, fontSize: 22),
        ),
        hSized10,
        SizedBox(
          height: 150,
          child: Text(
            provider.currentCard?.answer ?? '',
            style: regularTextStyle(color: MyColors.color949494, fontSize: 15),
          ),
        ),
        hSized15,
        Row(
          children: [
            if (provider.currentCard?.difficulty != null)
              _tagButton(provider.currentCard!.difficulty!),
            wSized10,
            _tagButton("PYQ"),
          ],
        ),
        hSized15,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (provider.currentIndex != 0)
              GestureDetector(
                onTap: provider.currentIndex == 0 ? null : provider.prevCard,
                child: SvgPicture.asset(IconsPath.backCart),
              ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                final totalCards =
                    provider.flashcardModel?.data?.flashcards?.length ?? 0;

                if (provider.currentIndex + 1 >= totalCards) {
                  // last card → show completion
                  CustomNavigator.pushRemoveUntil(
                    context,
                    FlashcardCompletionScreen(topicId: widget.topicId),
                  );
                } else {
                  await provider.nextCard(context, widget.topicId);
                  setState(() => _showAnswer = false);
                }
              },

              child: SvgPicture.asset(IconsPath.next),
            ),
          ],
        ),
      ],
    );
  }

  // ---------- Helper Buttons ----------
  Widget _tagButton(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: MyColors.color1BB287,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: semiBoldTextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  Widget _circularButton(String title, Color color) {
    return Container(
      width: 86,
      height: 86,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: semiBoldTextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
