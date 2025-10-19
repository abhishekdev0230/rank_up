import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/app_bar.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});

  // Sample FAQ data
  final List<Map<String, String>> faqs = [
    {
      "question": "How do I reset my password?",
      "answer": "Go to settings → Account → Reset Password and follow the instructions."
    },
    {
      "question": "How can I contact support?",
      "answer": "You can reach out via the 'Contact Us' option in the app or email support@example.com."
    },
    {
      "question": "How do I upgrade to premium?",
      "answer": "Go to the subscription page and select a premium plan to upgrade."
    },
    {
      "question": "How do I delete my account?",
      "answer": "You can delete your account from settings → Account → Delete Account."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "FAQ",
      body: ListView.separated(
        itemCount: faqs.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black12,
          thickness: 0.5,
        ),
        itemBuilder: (context, index) {
          final item = faqs[index];
          return ExpansionTile(
            childrenPadding: EdgeInsets.zero,
            tilePadding: EdgeInsets.zero,
            title: Text(
              item["question"]!,
              style: semiBoldTextStyle(fontSize: 14, color: MyColors.blackColor),
            ),
            children: [
              Text(
                item["answer"]!,
                style: mediumTextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          );
        },
      ),
    );
  }
}
