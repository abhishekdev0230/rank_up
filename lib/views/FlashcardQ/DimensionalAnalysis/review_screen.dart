import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/icon_path.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/models/review_provider.dart';

class ReviewScreen extends StatefulWidget {
  final String attemptId;

  const ReviewScreen({super.key, required this.attemptId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final filters = [
    "all",
    "correct",
    "wrong",
    "skipped",
    "bookmarked",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReviewProvider>(
        context,
        listen: false,
      ).fetchReview(context: context, attemptId: widget.attemptId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Review",
      backgroundColor: MyColors.appTheme,
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white, size: 26),
          color: Colors.white,
          onSelected: (value) {
            Provider.of<ReviewProvider>(context, listen: false).fetchReview(
              context: context,
              attemptId: widget.attemptId,
              filter: value,
            );
          },
          itemBuilder: (context) => filters
              .map(
                (f) => PopupMenuItem(
                  value: f,
                  child: Text(
                    f.toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              )
              .toList(),
        ),
      ],

      body: Consumer<ReviewProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CommonLoader(color: Colors.white));
          }

          final list = provider.reviewModel?.data ?? [];

          if (list.isEmpty) {
            return const Center(child: Text("No Questions Found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 12),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final q = list[index];

              return Card(
                color: MyColors.rankBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //-------------------------
                      // ⭐ QUESTION + BOOKMARK
                      //-------------------------
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${index + 1}. ${q.questionText}",
                              style: mediumTextStyle(fontSize: 15),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Provider.of<ReviewProvider>(
                                context,
                                listen: false,
                              ).toggleBookmark(
                                context: context,
                                attemptId: widget.attemptId,
                                questionId: q.id!,
                                isBookmarked: !(q.isBookmarked ?? false),
                                index: index,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: SvgPicture.asset(
                                  (q.isBookmarked ?? false)
                                      ? IconsPath.bookmarktrueCards
                                      : IconsPath.bokMarkSave,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      //-------------------------
                      // ⭐ OPTIONS
                      //-------------------------
                      Column(
                        children: q.options!.map((opt) {
                          final isSelected =
                              q.selectedAnswer == opt.optionLabel;
                          final isCorrect = q.correctAnswer == opt.optionLabel;

                          Color bg = Colors.white;
                          Color border = Colors.grey;

                          if (isSelected && q.isCorrect == false) {
                            bg = Colors.red.shade100;
                            border = Colors.red;
                          }

                          if (isCorrect) {
                            bg = Colors.green.shade100;
                            border = Colors.green;
                          }

                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: border),
                            ),
                            child: Text(
                              "${opt.optionLabel}. ${opt.optionText}",
                              style: regularTextStyle(
                                fontSize: 14,
                                color: MyColors.blackColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      //-------------------------
                      // ⭐ SHOW CORRECT ANSWER IF WRONG
                      //-------------------------
                      if (q.isCorrect == false)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Correct Answer: ${q.correctAnswer}",
                            style: mediumTextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                        ),

                      //-------------------------
                      // ⭐ EXPLANATION
                      //-------------------------
                      if (q.explanation != null && q.explanation!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Explanation:\n${q.explanation}",
                            style: regularTextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
