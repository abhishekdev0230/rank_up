import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

ValueNotifier<bool> redDotNotifier = ValueNotifier(false);
ValueNotifier<bool> notificationTrigger = ValueNotifier(false);

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");
bool? notificationsTitle = false;

@pragma('vm:entry-point')
Future<void> _backgroundHandler(NotificationResponse message) async {
  debugPrint('----backgroundHandler---');
  NotificationServices.handleResponse(message);
  debugPrint('----111---');
}

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
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

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    // onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSetting = InitializationSettings(
        android: androidInitialization, iOS: initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      debugPrint("payload>>>>>>$payload");

      // handleMessage(context, message);
      // handleMessage(Notifications.fromJson(message.data));
    });
  }

  ///handle tap on notification when app is in background or terminated

  Future<void> setupInteractMessage(BuildContext context) async {
    /// when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      //handleMessage(context, initialMessage);
    }

    ///when app is  background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (initialMessage != null) {
        //handleMessage(context, event);
        // handleMessage(Notifications.fromJson(event.data));
      }
    });

    ///When App is Open
    FirebaseMessaging.onMessage.listen((message) {
      notificationsTitle = true;
      redDotNotifier.value = true;
      notificationTrigger.value = true;
      if (kDebugMode) {
        print("title<><><>${message.notification?.title}");
        print("body<><><>${message.notification?.body}");
        print("data<><><>Notification : ${message.data}");
        print("notifications title : ${message.notification?.title}");
        print("notifications body : ${message.notification?.body}");

        print(
            "notifications click action:${message.notification?.android?.clickAction}");
        print("Data<><><>${message.data}");
      }
      //handleMessage(context, message);

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
      // else if (Platform.isIOS) {
      //   initLocalNotifications(context, message);
      //   showNotification(message);
      // }
    });
  }

  static handleResponse(
    NotificationResponse value,
  ) async {
    // SharedPreferences p = await SharedPreferences.getInstance();
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

  ///=========== navigate other screens==================================
  static navigateScreen(var jsonResponse) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // Map<String, dynamic> jsonRe = jsonDecode(jsonResponse);
    debugPrint("jsonRe.....${jsonResponse}");
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(Random.secure().nextInt(100000).toString(),
            'High Importance Notification',
            importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      androidNotificationChannel.id.toString(),
      androidNotificationChannel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.max,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      //  attachments: attachments,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }
  //
  // BigPictureStyleInformation? _buildBigPictureStyleInformation(
  //     String title,
  //     String body,
  //     String? picturePath,
  //     String? iosPicturePath,
  //     bool showBigPicture,
  //     ) {
  //   if (picturePath == null || iosPicturePath == null) return null;
  //   final FilePathAndroidBitmap filePath = FilePathAndroidBitmap(picturePath);
  //   return BigPictureStyleInformation(
  //     showBigPicture ? filePath : const FilePathAndroidBitmap("empty"),
  //     largeIcon: filePath,
  //     contentTitle: title,
  //     htmlFormatContentTitle: true,
  //     summaryText: body,
  //     htmlFormatSummaryText: true,
  //   );
  // }

  Future<void> handleMessage(data) async {
    debugPrint("get......");

    debugPrint("333>>>$data");

    String type = data.type.toString();
    debugPrint("444>>>${type}");

    try {
      if (type == "reminder") {
        debugPrint("Type: afasfg");
      } else {
        debugPrint("ffff......");
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

  void showNotificationWithImage(String imageUrl, String title, String body) {
    //  the notification here with CachedNetworkImage
    // final notification = Notification(
    //   title: title,
    //   body: body,
    //   imageUrl: imageUrl,
    // );
  }
}

class Notification {
  final String title;
  final String body;
  final String imageUrl;

  Notification(
      {required this.title, required this.body, required this.imageUrl});
}

Future<void> onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {}
