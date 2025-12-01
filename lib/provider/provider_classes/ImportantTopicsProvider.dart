// providers/important_topics_provider.dart
import 'package:flutter/material.dart';
import 'package:rank_up/models/HomeDataModel.dart';
import 'package:rank_up/models/ImportantTopicListModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';

class ImportantTopicsProvider extends ChangeNotifier {
  List<ImportantTopicSeeAll> topics = [];
  bool isLoading = false;
  int currentPage = 1;
  int totalPages = 1;
  String search = "";

  Future<void> fetchTopics({
    int page = 1,
    int limit = 10,
    String? searchKeyword,
  }) async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();

    try {
      final queryParameters = {
        "page": page.toString(),
        "limit": limit.toString(),
      };
      if (searchKeyword != null) queryParameters["search"] = searchKeyword;

      final raw = await ApiMethods().getMethod(
        method: ApiUrls.importantTopicsList,
        body: queryParameters,
        header: await ApiHeaders.withStoredToken(),
      );

      if (raw == null || raw.isEmpty) return;

      final model = importantTopicListModelFromJson(raw);

      if (page == 1) topics = model.data;
      else topics.addAll(model.data);

      currentPage = model.pagination.page;
      totalPages = model.pagination.totalPages;
    } catch (e) {
      print("🔥 ImportantTopics API Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool get hasMore => currentPage < totalPages;
}
