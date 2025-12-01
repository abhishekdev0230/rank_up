import 'package:flutter/material.dart';
import 'package:rank_up/models/NotificationModel.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'dart:convert';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;

  Future<void> fetchNotifications({int page = 1, int limit = 20}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final headers = await ApiHeaders.withStoredToken();
      final url = "${ApiUrls.notificationList}?page=$page&limit=$limit";

      final response = await ApiMethods().getMethod(
        method: url,
        body: {}, // GET request, body not needed
        header: headers,
      );

      if (response.isNotEmpty) {
        final Map<String, dynamic> jsonData = jsonDecode(response);

        // Access 'items' inside 'data'
        final items = jsonData['data']['items'] as List<dynamic>;

        _notifications =
            items.map((e) => NotificationModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error fetching notifications: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
