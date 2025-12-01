import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/custom_classes/loder.dart';

class FullAnalyticsScreen extends StatefulWidget {
  final String attemptId;

  const FullAnalyticsScreen({super.key, required this.attemptId});

  @override
  State<FullAnalyticsScreen> createState() => _FullAnalyticsScreenState();
}

class _FullAnalyticsScreenState extends State<FullAnalyticsScreen> {
  Map<String, dynamic>? analyticsData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAnalytics();
    });
  }

  Future<void> fetchAnalytics() async {
    try {
      CommonLoaderApi.show(context);
      final url =
      ApiUrls.testsFinelAnalytics.replaceFirst(":attemptId", widget.attemptId);
      final headers = await ApiHeaders.withStoredToken();

      final responseRaw = await ApiMethods().getMethod(
        method: url,
        body: {},
        header: headers,
      );

      CommonLoaderApi.hide(context);

      if (responseRaw == null || responseRaw.isEmpty) {
        Helper.customToast("Invalid API response");
        return;
      }

      final decoded = jsonDecode(responseRaw);
      final data = decoded['data']['data'];

      if (decoded['status'] == true && data != null) {
        setState(() {
          analyticsData = data;
        });
      } else {
        Helper.customToast(decoded['message'] ?? "No data");
      }
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Error fetching analytics");
      print("🔥 Analytics Error: $e");
    }
  }

  // ---------------------- Topic Card ----------------------
  Widget buildTopicCard(Map<String, dynamic> topic) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(topic['topicName'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            "Correct: ${topic['correct']} / Total: ${topic['total']} | Accuracy: ${topic['accuracy']}%"),
      ),
    );
  }

  // ---------------------- Difficulty Card ----------------------
  Widget buildDifficultyCard(Map<String, dynamic> diff) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(diff['difficulty'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            "Correct: ${diff['correct']} / Total: ${diff['total']} | Accuracy: ${diff['accuracy']}%"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Full Analytics",
      backgroundColor: MyColors.appTheme,
      body: analyticsData == null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.insert_chart_outlined, size: 60, color: MyColors.green),
              SizedBox(height: 12),
              Text(
                "No analytics data available.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: MyColors.green,
                ),
              ),
            ],
          ),
        ),
      )
          :SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------------- Attempt Info ----------------------
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: MyColors.rankBg,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Attempt Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Total Time: ${analyticsData!['totalTime']} min"),
                  Text(
                    "Percentile: ${analyticsData!['percentile']}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.green,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ---------------------- Topic Stats ----------------------
            if (analyticsData!['topicStats'] != null &&
                (analyticsData!['topicStats'] as List).isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Topic Performance",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
                  const SizedBox(height: 6),
                  ...List<Map<String, dynamic>>.from(
                      analyticsData!['topicStats'])
                      .map(buildTopicCard)
                      .toList(),
                ],
              ),
            const SizedBox(height: 16),

            // ---------------------- Difficulty Stats ----------------------
            if (analyticsData!['difficultyStats'] != null &&
                (analyticsData!['difficultyStats'] as List).isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Difficulty Stats",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
                  const SizedBox(height: 6),
                  ...List<Map<String, dynamic>>.from(
                      analyticsData!['difficultyStats'])
                      .map(buildDifficultyCard)
                      .toList(),
                ],
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
