import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/app_bar.dart';

class BlogScreen extends StatelessWidget {
  BlogScreen({super.key});

  // Sample blog data
  final List<Map<String, String>> blogs = [
    {
      "title": "Top 10 Tips to Improve Your Profile",
      "description": "Learn how to enhance your profile and attract more attention.",
      "date": "Oct 18, 2025"
    },
    {
      "title": "How Premium Subscription Can Help You",
      "description": "Discover the benefits of upgrading to premium.",
      "date": "Oct 15, 2025"
    },
    {
      "title": "New Features in Our App",
      "description": "Check out the latest updates and features available for you.",
      "date": "Oct 10, 2025"
    },
    {
      "title": "Safety Tips for Online Interactions",
      "description": "Important tips to stay safe while using the app.",
      "date": "Oct 5, 2025"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Blog",
      body: ListView.separated(
        itemCount: blogs.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black12,
          thickness: 0.5,
        ),
        itemBuilder: (context, index) {
          final item = blogs[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              item["title"]!,
              style: semiBoldTextStyle(fontSize: 14, color: MyColors.blackColor),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  item["description"]!,
                  style: mediumTextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  item["date"]!,
                  style: mediumTextStyle(fontSize: 10, color: Colors.black38),
                ),
              ],
            ),
            onTap: () {
              // Open blog details page if needed
            },
          );
        },
      ),
    );
  }
}
