import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/services/local_storage.dart';

class NotificationBadgeProvider extends ChangeNotifier {
  static const storageKey = 'notification_unread_count';
  static const lastBackgroundAtKey = 'notification_last_background_at';
  static const countedIdsKey = 'notification_counted_ids';

  static NotificationBadgeProvider? _instance;

  int _unreadCount = 0;

  int get unreadCount => _unreadCount;
  bool get hasUnread => _unreadCount > 0;

  NotificationBadgeProvider() {
    _instance = this;
    reloadFromStorage();
  }

  Future<void> reloadFromStorage() async {
    _unreadCount = await StorageManager.getInt(storageKey) ?? 0;
    notifyListeners();
  }

  /// Only when app is fully in background (NOT on inactive — that also fires on resume).
  static Future<void> markAppBackgrounded() async {
    await StorageManager.savingData(
      lastBackgroundAtKey,
      DateTime.now().toIso8601String(),
    );
  }

  static Future<bool> _registerNotificationId(String? id) async {
    final resolvedId = (id == null || id.isEmpty)
        ? 'fcm_${DateTime.now().millisecondsSinceEpoch}'
        : id;

    final countedIds =
        await StorageManager.getStringList(countedIdsKey) ?? <String>[];
    if (countedIds.contains(resolvedId)) return false;

    countedIds.add(resolvedId);
    await StorageManager.savingData(countedIdsKey, countedIds);
    return true;
  }

  static Future<void> incrementPersisted({String? notificationId}) async {
    final shouldIncrement = await _registerNotificationId(notificationId);
    if (!shouldIncrement) return;

    final current = await StorageManager.getInt(storageKey) ?? 0;
    final updated = current + 1;
    await StorageManager.savingData(storageKey, updated);

    final instance = _instance;
    if (instance != null) {
      instance._unreadCount = updated;
      instance.notifyListeners();
    }
  }

  static Future<DateTime?> _backgroundBaseline() async {
    final backgroundAt =
        await StorageManager.getString(lastBackgroundAtKey);
    if (backgroundAt != null) {
      return DateTime.tryParse(backgroundAt);
    }
    return null;
  }

  static Future<bool> _hasAuthToken() async {
    final token = await StorageManager.getString(StorageManager.accessToken);
    return token != null && token.isNotEmpty;
  }

  static Future<int> _countNewNotificationsSince(DateTime since) async {
    if (!await _hasAuthToken()) return 0;

    try {
      final headers = await ApiHeaders.withStoredToken();
      final response = await ApiMethods().getMethod(
        method: '${ApiUrls.notificationList}?page=1&limit=50',
        body: {},
        header: headers,
      );

      if (response.isEmpty) return 0;

      final jsonData = jsonDecode(response) as Map<String, dynamic>;
      final data = jsonData['data'];
      if (data is! Map<String, dynamic>) return 0;

      final items = data['items'] as List<dynamic>? ?? [];
      final countedIds =
          await StorageManager.getStringList(countedIdsKey) ?? <String>[];
      final updatedIds = [...countedIds];
      var newCount = 0;

      // Small buffer for clock skew between device and server.
      final sinceWithBuffer = since.subtract(const Duration(seconds: 5));

      for (final item in items) {
        if (item is! Map<String, dynamic>) continue;

        final id = item['id']?.toString() ?? '';
        final createdAt =
            DateTime.tryParse(item['createdAt']?.toString() ?? '');
        if (id.isEmpty || createdAt == null) continue;
        if (countedIds.contains(id)) continue;

        if (!createdAt.isBefore(sinceWithBuffer)) {
          newCount++;
          updatedIds.add(id);
        }
      }

      if (newCount > 0) {
        await StorageManager.savingData(countedIdsKey, updatedIds);
      }

      return newCount;
    } catch (e) {
      debugPrint('Notification badge sync error: $e');
      return 0;
    }
  }

  Future<void> syncOnAppResume() async {
    final storedCount = await StorageManager.getInt(storageKey) ?? 0;
    _unreadCount = storedCount;

    final since = await _backgroundBaseline();
    if (since != null) {
      final apiNewCount = await _countNewNotificationsSince(since);
      if (apiNewCount > 0) {
        _unreadCount += apiNewCount;
        await StorageManager.savingData(storageKey, _unreadCount);
      }
    }

    // Reset baseline after sync so the same notifications are not re-counted.
    await markAppBackgrounded();
    notifyListeners();
  }

  static Future<void> handleAppResumed() async {
    final instance = _instance;
    if (instance != null) {
      await instance.syncOnAppResume();
      return;
    }

    final storedCount = await StorageManager.getInt(storageKey) ?? 0;
    final since = await _backgroundBaseline();
    var updatedCount = storedCount;

    if (since != null) {
      final apiNewCount = await _countNewNotificationsSince(since);
      if (apiNewCount > 0) {
        updatedCount += apiNewCount;
        await StorageManager.savingData(storageKey, updatedCount);
      }
    }

    await markAppBackgrounded();
  }

  Future<void> clearUnread() async {
    _unreadCount = 0;
    await StorageManager.savingData(storageKey, 0);
    notifyListeners();
  }
}
