import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/app_bar.dart';

class MyQueriesScreen extends StatelessWidget {
  MyQueriesScreen({super.key});

  // Sample query data
  final List<Map<String, String>> queries = [
    {
      "question": "How can I upgrade to premium?",
      "status": "Pending",
      "date": "Oct 18, 2025"
    },
    {
      "question": "I cannot access my bookmarked cards.",
      "status": "Resolved",
      "date": "Oct 15, 2025"
    },
    {
      "question": "How to reset my account?",
      "status": "Pending",
      "date": "Oct 10, 2025"
    },
    {
      "question": "Is there a referral program?",
      "status": "Resolved",
      "date": "Oct 5, 2025"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "My Queries",
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 25),
        itemCount: queries.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final query = queries[index];
          return Container(
            decoration: BoxDecoration(
              color: MyColors.whiteText,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  query["question"]!,
                  style: semiBoldTextStyle(fontSize: 14, color: MyColors.blackColor),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: query["status"] == "Resolved"
                            ? Colors.green.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        query["status"]!,
                        style: mediumTextStyle(
                          fontSize: 12,
                          color: query["status"] == "Resolved" ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                    Text(
                      query["date"]!,
                      style: mediumTextStyle(fontSize: 10, color: Colors.black38),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
