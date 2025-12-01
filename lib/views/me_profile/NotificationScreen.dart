import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_up/constraints/my_colors.dart';
import 'package:rank_up/constraints/my_fonts_style.dart';
import 'package:rank_up/custom_classes/app_bar.dart';
import 'package:rank_up/provider/provider_classes/NotificationProvider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider()..fetchNotifications(),
      child: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          return CommonScaffold(
            title: "Notifications",
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.notifications.isEmpty
                ? const Center(child: Text("No notifications"))
                : ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: provider.notifications.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black12,
                thickness: 0.5,
              ),
              itemBuilder: (context, index) {
                final item = provider.notifications[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    item.title,
                    style: semiBoldTextStyle(
                        fontSize: 14, color: MyColors.blackColor),
                  ),
                  subtitle: Text(
                    item.message,
                    style: mediumTextStyle(
                        fontSize: 12, color: Colors.black54),
                  ),
                  trailing: Text(
                    timeAgo(item.createdAt),
                    style: mediumTextStyle(
                        fontSize: 10, color: Colors.black38),
                  ),
                  onTap: () {
                    // Handle notification tap, e.g. navigate using item.data
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hour ago';
    return '${diff.inDays} days ago';
  }
}
