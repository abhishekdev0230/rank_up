import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/provider/provider_classes/flashcard_chapter_provider.dart';
import 'package:rank_up/views/FlashcardQ/classIn_study_all_flashcards.dart';

class FlashcardInnerPhysicsScreen extends StatefulWidget {
  final String selectIndexId;
  final String selectClass;

  const FlashcardInnerPhysicsScreen({
    super.key,
    required this.selectIndexId,
    required this.selectClass,
  });

  @override
  State<FlashcardInnerPhysicsScreen> createState() =>
      _FlashcardInnerPhysicsScreenState();
}

class _FlashcardInnerPhysicsScreenState
    extends State<FlashcardInnerPhysicsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<FlashcardChapterProvider>();
      if (provider.chapterModel == null && !provider.isLoading) {
        provider.fetchChapters(context, widget.selectIndexId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlashcardChapterProvider>(context);
    final chapters = provider.chapterModel?.data ?? [];

    return CommonScaffold(
      title: "Flashcards",
      showBack: true,
      backgroundColor: MyColors.appTheme,
      body: provider.isLoading
          ? const Center(child: CommonLoader(color: Colors.white))
          : RefreshIndicator(
              color: MyColors.appTheme,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await provider.fetchChapters(
                  context,
                  widget.selectIndexId,
                  isPullRefresh: true,
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hSized15,
                    Text(
                      "${widget.selectClass} Topics",
                      style: semiBoldTextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    hSized10,
                    if (provider.chapterModel?.data == null ||
                        provider.chapterModel!.data!.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: Text(
                            "No chapters found",
                            style: regularTextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.chapterModel!.data!.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final topic = provider.chapterModel!.data![index];
                          return GestureDetector(
                            onTap: () {

                              CustomNavigator.pushNavigate(
                                context,
                                ClassStudyFlashcardsScreen(
                                  type: topic.name ?? "",
                                  selectId: topic.id ?? "",
                                ),
                              );
                            },

                            child: _chapterCard(
                              title: topic.name ?? "Untitled",
                              flashcards: topic.totalFlashcards ?? 0,
                              quizzes: topic.totalQuestions ?? 0,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  /// ---------------- Chapter Card Widget ----------------
  Widget _chapterCard({
    required String title,
    required int flashcards,
    required int quizzes,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F4E79),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: semiBoldTextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            "$flashcards Flashcards | $quizzes Quizzes",
            style: regularTextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
