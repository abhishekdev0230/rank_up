import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/constraints/sizdebox_width.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/provider/provider_classes/flashcard_provider.dart';
import 'package:rank_up/views/FlashcardQ/NeetPYQsFlashcardsInner.dart';
import 'package:rank_up/views/FlashcardQ/flashcards_innner_1.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FlashcardProvider>(context, listen: false).init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlashcardProvider>(context);
    final recentlyViewed = provider.flashcardData?.data?.recentlyViewed ?? [];
    final subjects = provider.flashcardData?.data?.subjects;

    return CommonScaffold(
      title: "Flashcards",
      showBack: false,
      backgroundColor: MyColors.appTheme,
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CommonLoader(color: Colors.white))
            : RefreshIndicator(
                color: MyColors.appTheme,
                onRefresh: () async {
                  // Pull-to-refresh: refresh without showing full-page loader
                  await provider.init(context, showLoader: false);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hSized10,

                      /// ---------------- Tabs ----------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          final tabNames = ["Class 11", "Class 12", "Achiever"];
                          final isSelected = provider.selectedTab == index;
                          return GestureDetector(
                            onTap: () => provider.changeTab(index, context),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? MyColors.green
                                    : MyColors.color295176,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                tabNames[index],
                                style: mediumTextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 28),

                      /// ---------------- Featured Subjects ----------------
                      Column(
                        children: [
                          Text(
                            "Featured Subjects",
                            style: semiBoldTextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                      hSized10,
                      provider.isTabLoading
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: const Center(
                                child: CommonLoader(color: Colors.white),
                              ),
                            )
                          : subjects == null
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: const Center(
                                child: Text(
                                  "No subjects found",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : Column(
                              children: subjects.map((subject) {
                                String classCode = provider.selectedTab == 0
                                    ? "11"
                                    : provider.selectedTab == 1
                                    ? "12"
                                    : "Achiever";

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: _subjectCard(
                                    context: context,
                                    title: subject.name ?? "Unknown",
                                    subtitle: subject.description ?? "",
                                    subjectId: subject.id ?? "",
                                    selectedClassCode: classCode,
                                  ),
                                );
                              }).toList(),
                            ),
                      hSized28,

                      /// ---------------- Recently Viewed ----------------
                      Text(
                        "Recently Viewed",
                        style: semiBoldTextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      recentlyViewed.isEmpty
                          ? Text(
                              "No recent topics viewed",
                              style: regularTextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: recentlyViewed
                                    .map(
                                      (item) => _recentCard(
                                        item.topicName ?? "Untitled",
                                        onTab: () {
                                          CustomNavigator.pushNavigate(
                                            context,
                                            NeetPYQsFlashcardsInner(
                                              topicId: item.topicId.toString(),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                      hSized15,
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  /// ---------------- Subject Card ----------------
  Widget _subjectCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String subjectId,
    required String selectedClassCode,
  }) {
    return GestureDetector(
      onTap: () => CustomNavigator.pushNavigate(
        context,
        FlashcardInnerPhysicsScreen(
          selectIndexId: subjectId,
          selectClass: selectedClassCode,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColors.color295176,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.book_rounded, color: Colors.white, size: 28),
                wSized5,
                Expanded(
                  child: Text(
                    maxLines: 1,
                    title,
                    style: semiBoldTextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              maxLines: 2,
              subtitle,
              style: regularTextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentCard(String title, {required VoidCallback onTab}) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 93,
        width: 117,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: MyColors.color295176,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(IconsPath.flashQ),
            hSized10,
            Text(
              maxLines: 2,
              title,
              style: regularTextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
