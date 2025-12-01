import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/provider/provider_classes/ImportantTopicsProvider.dart';
import 'package:rank_up/views/FlashcardQ/NeetPYQsFlashcardsInner.dart';
import '../../models/ImportantTopicListModel.dart';
import '../../constraints/my_colors.dart';
import '../../constraints/my_fonts_style.dart';

class ImportantTopicsScreen extends StatefulWidget {
  const ImportantTopicsScreen({super.key});

  @override
  State<ImportantTopicsScreen> createState() => _ImportantTopicsScreenState();
}

class _ImportantTopicsScreenState extends State<ImportantTopicsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Fetch topics after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
      Provider.of<ImportantTopicsProvider>(context, listen: false);
      provider.fetchTopics();
    });

    // Infinite scroll listener
    _scrollController.addListener(() {
      final provider =
      Provider.of<ImportantTopicsProvider>(context, listen: false);
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        if (provider.hasMore && !provider.isLoading) {
          provider.fetchTopics(page: provider.currentPage + 1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Important Topics",
      appBarBackgroundColor: MyColors.darkBlue,
      backgroundColor: MyColors.darkBlue,
      body: Consumer<ImportantTopicsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.topics.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!provider.isLoading && provider.topics.isEmpty) {
            return Center(
              child: Text(
                "No Important Topics Found",
                style: semiBoldTextStyle(
                    fontSize: 16, color: MyColors.whiteText),
              ),
            );
          }
          return ListView.separated(
            controller: _scrollController,
            itemCount: provider.topics.length + (provider.hasMore ? 1 : 0),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              if (index == provider.topics.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final topic = provider.topics[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                color: MyColors.color295176,
                child: ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(
                    topic.name,
                    style: semiBoldTextStyle(
                        fontSize: 16, color: MyColors.whiteText),
                  ),
                  subtitle: Text(
                    topic.description ?? "No description available",
                    style:
                    regularTextStyle(fontSize: 14, color: MyColors.whiteText),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: MyColors.appTheme,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      "Q: ${topic.totalQuestions}, F: ${topic.totalFlashcards}",
                      style: mediumTextStyle(
                          fontSize: 12, color: MyColors.whiteText),
                    ),
                  ),
                  onTap: () {
                    print("Tapped topic: ${topic.name}");
                    if (topic.id != null) {
                      CustomNavigator.pushNavigate(
                        context,
                        NeetPYQsFlashcardsInner(topicId: topic.id.toString()),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
