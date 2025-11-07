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

class FlashcardInnerPhysicsScreen extends StatelessWidget {
  final String selectIndexId;
  final String selectClass;

  const FlashcardInnerPhysicsScreen({
    super.key,
    required this.selectIndexId,
    required this.selectClass,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlashcardChapterProvider>(context);

    // Fetch data after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.chapterModel == null && !provider.isLoading) {
        provider.fetchChapters(context, selectIndexId);
      }
    });

    final chapters = provider.chapterModel?.data ?? [];

    return CommonScaffold(
      title: "Flashcards",
      showBack: true,
      backgroundColor: MyColors.appTheme,
      body: provider.isLoading
          ? const Center(child: CommonLoader(color: Colors.white))
          : chapters.isEmpty
          ? Center(
              child: Text(
                "No chapters found",
                style: regularTextStyle(color: Colors.white70, fontSize: 15),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hSized20,
                Text(
                  "$selectClass Topics",
                  style: semiBoldTextStyle(color: Colors.white, fontSize: 19),
                ),
                const SizedBox(height: 16),

                /// ---------------- Chapters List ----------------
                Expanded(
                  child: ListView.separated(
                    itemCount: chapters.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final topic = chapters[index];
                      return GestureDetector(
                        onTap: () {
                          print(">>>>>>>>>>>>>>>>>${topic.id}");
                          CustomNavigator.pushNavigate(
                            context,
                            ClassStudyFlashcardsScreen(type:topic.name ?? "" ,selectId: topic.id ?? "",),
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
                ),
              ],
            ),
    );
  }

  /// ---------------- Chapter Card Widget (UI same as image) ----------------
  Widget _chapterCard({
    required String title,
    required int flashcards,
    required int quizzes,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F4E79), // Matches your blue tone
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: semiBoldTextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),

          // Subtitle (flashcards + quizzes)
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
