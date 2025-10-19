import 'package:flutter/material.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/app_bar.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  // Sample notification data
  final List<Map<String, String>> notifications = [
    {
      "title": "New Message",
      "subtitle": "You have a new message from John",
      "time": "2 min ago"
    },
    {
      "title": "App Update",
      "subtitle": "Version 2.0 is now available",
      "time": "1 hour ago"
    },
    {
      "title": "Subscription Expired",
      "subtitle": "Your premium subscription expired",
      "time": "Yesterday"
    },
    {
      "title": "Reminder",
      "subtitle": "Complete your profile for better suggestions",
      "time": "2 days ago"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
   title: "Notifications",

      body: ListView.separated(
        padding: EdgeInsets.zero,

        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black12,
          thickness: 0.5,
        ),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              item["title"]!,
              style: semiBoldTextStyle(fontSize: 14, color: MyColors.blackColor),
            ),
            subtitle: Text(
              item["subtitle"]!,
              style: mediumTextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Text(
              item["time"]!,
              style: mediumTextStyle(fontSize: 10, color: Colors.black38),
            ),
            onTap: () {
              // Add your onTap action here if needed
            },
          );
        },
      ),
    );
  }
}
