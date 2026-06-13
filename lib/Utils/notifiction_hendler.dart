import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rank_up/provider/provider_classes/NotificationBadgeProvider.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

@pragma('vm:entry-point')
Future<void> _backgroundHandler(NotificationResponse message) async {
  debugPrint('----backgroundHandler---');
  NotificationServices.handleResponse(message);
  debugPrint('----111---');
}

class NotificationServices {
  static const String channelId = 'high_importance_channel';
  static const String channelName = 'Rank Up Notifications';

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (Platform.isIOS) {
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('user granted provisional permission');
    } else {
      debugPrint('user denied permission');
    }
  }

  Future<void> initializeNotifications() async {
    if (_initialized) return;

    const androidInitialization =
        AndroidInitializationSettings('@drawable/ic_notification');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSetting = InitializationSettings(
      android: androidInitialization,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {
        debugPrint("payload>>>>>>$payload");
      },
    );

    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              channelId,
              channelName,
              description: 'Rank Up app notifications',
              importance: Importance.high,
            ),
          );
    }

    _initialized = true;
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    await initializeNotifications();

    final initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      await NotificationBadgeProvider.incrementPersisted(
        notificationId: _notificationId(initialMessage),
      );
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      await NotificationBadgeProvider.incrementPersisted(
        notificationId: _notificationId(message),
      );
    });

    FirebaseMessaging.onMessage.listen((message) async {
      await NotificationBadgeProvider.incrementPersisted(
        notificationId: _notificationId(message),
      );

      if (kDebugMode) {
        print("title<><><>${message.notification?.title}");
        print("body<><><>${message.notification?.body}");
        print("data<><><>Notification : ${message.data}");
      }

      if (Platform.isAndroid) {
        await showNotification(message);
      }
    });
  }

  static String? _notificationId(RemoteMessage message) {
    return message.messageId ??
        message.data['notificationId']?.toString() ??
        message.data['id']?.toString();
  }

  static handleResponse(NotificationResponse value) async {
    var s = value.payload.toString();
    var kv = s.substring(0, s.length - 1).substring(1).split(", ");
    final Map<String, String> pairs = {};
    for (int i = 0; i < kv.length; i++) {
      var thisKV = kv[i].split(":");
      pairs[thisKV[0]] = thisKV[1].trim();
    }
    var encoded = json.encode(pairs);
    var jsonResponse = convert.jsonDecode(encoded);
    debugPrint("11111111000000");
    navigateScreen(jsonResponse);
  }

  static navigateScreen(var jsonResponse) async {
    debugPrint("jsonRe.....$jsonResponse");
  }

  Future<void> showNotification(RemoteMessage message) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Rank Up app notifications',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@drawable/ic_notification',
      color: Color(0xFF1E3F5E),
      ticker: 'Rank Up',
    );

    const darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'Rank Up',
      message.notification?.body ?? '',
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  Future<void> handleMessage(data) async {
    debugPrint("333>>>$data");

    String type = data.type.toString();
    debugPrint("444>>>$type");

    try {
      if (type == "reminder") {
        debugPrint("Type: reminder");
      } else {
        debugPrint("Other notification type");
      }
    } catch (e) {
      debugPrint("Navigation error: $e");
    }
  }

  static Future<bool> onCallBack(BuildContext context) async {
    return true;
  }

  static void updateOnCallBack() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }
}

Future<void> onDidReceiveLocalNotification(
  int id,
  String? title,
  String? body,
  String? payload,
) async {}
