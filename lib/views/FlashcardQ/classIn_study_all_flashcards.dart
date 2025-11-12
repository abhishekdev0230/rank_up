import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/provider/provider_classes/flashcard_topics_provider.dart';
import 'package:rank_up/views/FlashcardQ/DimensionalAnalysis/dimensional_analysis.dart';

class ClassStudyFlashcardsScreen extends StatefulWidget {
  final String type;
  final String selectId;

  const ClassStudyFlashcardsScreen({
    super.key,
    required this.type,
    required this.selectId,
  });

  @override
  State<ClassStudyFlashcardsScreen> createState() =>
      _ClassStudyFlashcardsScreenState();
}

class _ClassStudyFlashcardsScreenState
    extends State<ClassStudyFlashcardsScreen> {
  bool _isFetched = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FlashcardTopicsProvider>(
        context,
        listen: false,
      );
      if (!_isFetched) {
        _isFetched = true;
        provider.fetchTopics(context, widget.selectId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlashcardTopicsProvider>(context);
    final topics = provider.topicsModel?.data ?? [];

    return CommonScaffold(
      title: widget.type,
      showBack: true,
      backgroundColor: MyColors.appTheme,
      body: provider.isLoading
          ? const Center(child: CommonLoader(color: Colors.white))
          : RefreshIndicator(
              color: MyColors.appTheme,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await provider.fetchTopics(
                  context,
                  widget.selectId,
                  isPullRefresh: true,
                );
              },
              child: topics.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 200),
                        Center(
                          child: Text(
                            "No topics found",
                            style: regularTextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            hSized20,
                            Text(
                              "Study All ${_getTotalFlashcards(topics)} Flashcards",
                              style: semiBoldTextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: topics.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final topic = topics[index];
                                return GestureDetector(
                                  onTap: () async {
                                    final provider = context
                                        .read<FlashcardTopicsProvider>();
                                    await provider.viewChapters(
                                      context,
                                      topic.id ?? "",
                                    );

                                    CustomNavigator.pushNavigate(
                                      context,
                                      DimensionalAnalysis(totalFlashcards: topic.totalFlashcards.toString(),type: topic.id ?? "",topicId: topic.id ?? "",),
                                    );
                                  },
                                  child: _topicCard(
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
            ),
    );
  }

  num _getTotalFlashcards(List topics) {
    num total = 0;
    for (var t in topics) {
      total += (t.totalFlashcards ?? 0);
    }
    return total;
  }

  Widget _topicCard({
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
          Row(
            children: [
              const Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
                size: 26,
              ),
              wSized8,
              Expanded(
                child: Text(
                  title,
                  style: semiBoldTextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
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
