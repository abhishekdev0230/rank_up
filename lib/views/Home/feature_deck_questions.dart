import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/constraints/sizedbox_height.dart';
import 'package:rank_up/views/Home/home_view.dart';
import '../../constraints/my_colors.dart';
import '../../provider/provider_classes/featured_deck_questions_provider.dart';

class FeaturedDeckFlashcardsScreen extends StatefulWidget {
  final String deckId;
  final String deckName;

  const FeaturedDeckFlashcardsScreen({
    super.key,
    required this.deckId,
    required this.deckName,
  });

  @override
  State<FeaturedDeckFlashcardsScreen> createState() =>
      _FeaturedDeckFlashcardsScreenState();
}

class _FeaturedDeckFlashcardsScreenState
    extends State<FeaturedDeckFlashcardsScreen> {
  PageController pageController = PageController();
  bool showAnswer = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<FeaturedDeckQuestionsProvider>(
        context,
        listen: false,
      ).init(widget.deckId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: MyColors.appTheme,
      title: widget.deckName,
      body: Consumer<FeaturedDeckQuestionsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final totalCards = provider.questions.length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              hSized20,

              Container(
                constraints: const BoxConstraints(
                  minHeight: 300,
                  maxHeight: 400,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return PageView.builder(
                      controller: pageController,
                      itemCount: provider.questions.length,
                      onPageChanged: (index) {
                        setState(() => showAnswer = false);

                        if (index == provider.questions.length - 3) {
                          provider.loadMore();
                        }
                      },
                      itemBuilder: (context, index) {
                        final q = provider.questions[index];

                        return AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 16,
                            ),
                            padding: const EdgeInsets.all(20),

                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  MyColors.rankBg.withOpacity(0.9),
                                  MyColors.rankBg.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 12,
                                  offset: Offset(2, 4),
                                ),
                              ],
                            ),

                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                /// Card Count
                                Row(
                                  children: [
                                    Text(

                                      "Card ${index + 1}/${provider.questions.length}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 40),

                                /// Question
                                Text(
                                  textAlign: TextAlign.center,
                                  "Q: ${q.question}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87,
                                    height: 1.3,
                                  ),
                                ),

                                const SizedBox(height: 30),

                                /// Answer Section
                                if (showAnswer)
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 350,
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Ans ",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            height: 1.4,
                                          ),
                                        ), Text(
                                          q.answer ?? "",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                const SizedBox(height: 10),

                                /// Pagination Loader
                                if (index == provider.questions.length - 1 &&
                                    provider.isLoadingMore)
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                Spacer(),
                                Center(
                                  child: CommonButton1(
                                    height: 35,
                                    width: 160,
                                    title: "Reveal Answer",
                                    onPressed: () {
                                      setState(() => showAnswer = true);
                                    },
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
              ),
            ],
          );
        },
      ),
    );
  }
}
