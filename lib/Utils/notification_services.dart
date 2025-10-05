// // // import 'dart:convert';
// // // import 'dart:math';
// // // import 'package:firebase_core/firebase_core.dart';
// // // import 'package:firebase_messaging/firebase_messaging.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // import 'package:fluttertoast/fluttertoast.dart';
// // // import 'package:karigym/Storage/local_storage.dart';
// // // import 'package:karigym/Utils/helper.dart';
// // // import 'package:karigym/models/notification_list_model.dart';
// // // import 'package:karigym/screen/home/booking_details_my_booking.dart';
// // // import 'package:karigym/screen/invitation/invitation_card.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'dart:convert' as convert;
// // //
// // //
// // // @pragma('vm:entry-point')
// // // Future<void> _backgroundHandler(NotificationResponse message) async {
// // //   debugPrint('----backgroundHandler---');
// // //   NotificationService.handleResponse(message);
// // //   debugPrint('----111---');
// // // }
// // //
// // // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// // // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// // // bool? notificationsTitle = false;
// // //
// // // class NotificationService {
// // //   static final FlutterLocalNotificationsPlugin
// // //   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// // //
// // //   static void initialize() async {
// // //
// // //     debugPrint('FirebaseMessaging.onMessage.listen');
// // //     const InitializationSettings initializationSettings =
// // //     InitializationSettings(
// // //         android: AndroidInitializationSettings('@mipmap/ic_launcher'),
// // //         iOS: DarwinInitializationSettings(
// // //             requestAlertPermission: true,
// // //             requestBadgePermission: true,
// // //             requestSoundPermission: true,
// // //             onDidReceiveLocalNotification: onDidReceiveLocalNotification)
// // //     );
// // //     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// // //     _flutterLocalNotificationsPlugin.initialize(
// // //       initializationSettings,
// // //       onDidReceiveBackgroundNotificationResponse: _backgroundHandler,
// // //       onDidReceiveNotificationResponse: (message) => handleResponse(message),
// // //
// // //     );
// // //
// // //     _flutterLocalNotificationsPlugin
// // //         .resolvePlatformSpecificImplementation<
// // //         AndroidFlutterLocalNotificationsPlugin>()
// // //         ?.requestNotificationsPermission();
// // //
// // //
// // //     await _flutterLocalNotificationsPlugin
// // //         .resolvePlatformSpecificImplementation<
// // //         AndroidFlutterLocalNotificationsPlugin>()
// // //         ?.createNotificationChannel(
// // //       const AndroidNotificationChannel(
// // //           "high_importance_channel",
// // //           "High Importance Notifications",
// // //           importance: Importance.max,
// // //           playSound: true,
// // //           showBadge: true,
// // //           enableVibration: true
// // //       ),
// // //     );
// // //
// // //     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
// // //       alert: true, // Required to display a heads up notification
// // //       badge: true,
// // //       sound: true,
// // //     );
// // //
// // //     try {
// // //       await FirebaseMessaging.instance.setAutoInitEnabled(true);
// // //       String? fcmToken;
// // //       try {
// // //         fcmToken = await FirebaseMessaging.instance.getToken();
// // //       } catch (e) {
// // //         try {
// // //           fcmToken = await FirebaseMessaging.instance.getToken();
// // //         } catch (e) {
// // //           fcmToken = await FirebaseMessaging.instance.getAPNSToken();
// // //         }
// // //       }
// // //       debugPrint('--fcmToken---${fcmToken.toString()}----');
// // //       if (fcmToken?.isNotEmpty ?? false) {
// // //         StorageManager.savingData(StorageManager.fcmToken, fcmToken.toString());
// // //       }
// // //     } catch (e) {
// // //       Helper.customToast(e.toString());
// // //     }
// // //     notificationsTitle = true;
// // //     FirebaseMessaging.onMessage.listen(
// // //           (message) async {
// // //         debugPrint('FirebaseMessaging.onMessage.listen11');
// // //         RemoteNotification? notification = message.notification;
// // //         AndroidNotification? android = message.notification?.android;
// // //         // If `onMessage` is triggered with a notification, construct our own
// // //         // local notification to show to users using the created channel.
// // //         if (notification != null && android != null) {
// // //           display(message);
// // //         }
// // //         //FlutterRingtonePlayer.playNotification();
// // //       },
// // //     );
// // //
// // //     /// when app is in the terminated state
// // //     FirebaseMessaging.instance.getInitialMessage().then(
// // //           (message) {
// // //         debugPrint('FirebaseMessaging.onMessage.listen12');
// // //         if (message != null) {
// // //           //FlutterRingtonePlayer.playNotification();
// // //           try {
// // //             handleMessage(Notifications.fromJson(message.data));
// // //             debugPrint("2222");
// // //           } catch (e) {
// // //             debugPrint('>>>>FirebaseMessaging.instance.getInitialMessage>>>>${e.toString()}<<<<<<<<');
// // //           }
// // //         }
// // //       },
// // //     );
// // //
// // //     /// when app is in the foreground or background tap
// // //     FirebaseMessaging.onMessageOpenedApp.listen(
// // //           (message) {
// // //         debugPrint('FirebaseMessaging.onMessage.listen');
// // //         try {
// // //           handleMessage(Notifications.fromJson(message.data),
// // //           );
// // //           debugPrint("3333");
// // //         } catch (e) {
// // //           debugPrint(
// // //               '>>>>FirebaseMessaging.onMessageOpenedApp.listen>>>>${e.toString()}<<<<<<<<');
// // //         }
// // //       },
// // //     );
// // //   }
// // //   static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// // //     await Firebase.initializeApp();
// // //     print('Handling a background message ${message.messageId}');
// // //     print('${message.data}');
// // //     _flutterLocalNotificationsPlugin.show(
// // //       message.data.hashCode,
// // //       message.data['title'],
// // //       message.data['body'],
// // //       const NotificationDetails(
// // //         android: AndroidNotificationDetails(
// // //           'MyID',
// // //           'MyName',
// // //           channelDescription: 'MyDescription',
// // //           importance: Importance.max,
// // //           priority: Priority.high,
// // //           playSound: true,
// // //           ticker: 'ticker',
// // //           icon: ('@mipmap/ic_launcher'),
// // //           sound: RawResourceAndroidNotificationSound('assets/images/sound.mp3'),
// // //           // sound: UriAndroidNotificationSound("assets/sounds/classic.mp3"),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   static Future<void> handleMessage(data) async {
// // //     debugPrint("get......");
// // //
// // //     debugPrint("333>>>$data");
// // //
// // //     String type = data.type.toString();
// // //     debugPrint("444>>>${type}");
// // //
// // //     try {
// // //       if(type == "reminder"){
// // //         debugPrint("Type: afasfg");
// // //
// // //         navigatorKey.currentState?.pushAndRemoveUntil(
// // //           MaterialPageRoute(builder: (context) => BookingDetailMyBooking(selectedId: data.bookingId.toString(), onCallBack: onCallBack,) ),
// // //               (route) => false,
// // //         );
// // //       }else{
// // //         debugPrint("ffff......");
// // //         navigatorKey.currentState?.pushAndRemoveUntil(
// // //           MaterialPageRoute(
// // //               builder: (context) => Invitation(automaticallyImplyLeading: true, onCallBack: onCallBack, onCountUpdate: updateOnCallBack,)),
// // //               (route) => false,
// // //         );
// // //       }
// // //
// // //     } catch (e) {
// // //       debugPrint("Navigation error: $e");
// // //     }
// // //   }
// // //
// // //   static Future<bool> onCallBack() async {
// // //     // Navigator.of(context).pop();
// // //     // widget.onCallBack();
// // //     // setState(() {});
// // //     return true;
// // //   }
// // //
// // //   static void updateOnCallBack() {
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       // Future.delayed(Duration.zero, () async {
// // //       //   await invitationResponse(currentPage);
// // //       // });
// // //     });
// // //   }
// // //
// // //
// // // /*  static Future<void> handleMessage(RemoteMessage message) async {
// // //     // SharedPreferences prefs = await SharedPreferences.getInstance();
// // //     print("get......");
// // //
// // //     String NotificationScreenOpen = "notification_redirect";
// // //
// // //     print("printNotificationRedirect>>>$NotificationScreenOpen");
// // //
// // //     String clickType = message.data['click_type'].toString();
// // //     String id = message.data['n_id'].toString();
// // //
// // //     print("id>>><<<$id...........$clickType");
// // //
// // //     try {
// // //       if (clickType == "booking_cancelled_owner") {
// // //         navigatorKey.currentState?.push(MaterialPageRoute(
// // //           builder: (context) => PastReservationScreen(
// // //             model: null,
// // //             bookingId: id.toString(),
// // //             type: 'notification',
// // //             onUpdate: () {},
// // //           ),
// // //         ));
// // //       }
// // //       else if ( clickType == "booking" || clickType == "booking_cancelled_user") {
// // //         navigatorKey.currentState?.push(MaterialPageRoute(
// // //           builder: (context) =>  CalenderView(type: 'Notification', id: id,),
// // //         ));
// // //       }
// // //       else if (clickType == "chat") {
// // //         debugPrint("data.nId.toString()......${id.toString()}");
// // //         LocalStorageServices.savingData("n_id", id.toString());
// // //         LocalStorageServices.savingData("n_type", "Notification");
// // //         LocalStorageServices.savingData("r_name", message.data['name'].toString());
// // //         LocalStorageServices.savingData("n_image",  ApiPath.imgBaseUrl +message.data['image'].toString());
// // //
// // //         navigatorKey.currentState?.push(MaterialPageRoute(
// // //           builder: (context) => DashBoardScreen(tabIndex: 2,),
// // //         ));
// // //       }
// // //       else {
// // //         navigatorKey.currentState?.push(MaterialPageRoute(
// // //           builder: (context) => DashBoardScreen(),
// // //         ));
// // //       }
// // //     } catch (e) {
// // //       debugPrint("Navigation error: $e");
// // //     }
// // //   }*/
// // //
// // //   static  handleResponse(NotificationResponse value,) async{
// // //     SharedPreferences p = await SharedPreferences.getInstance();
// // //     var s = value.payload.toString();
// // //     var kv = s.substring(0,s.length-1).substring(1).split(", ");
// // //     final Map<String, String> pairs = {};
// // //     for (int i=0; i < kv.length;i++){
// // //       var thisKV = kv[i].split(":");
// // //       pairs[thisKV[0]] =thisKV[1].trim();
// // //     }
// // //     var encoded = json.encode(pairs);
// // //     var jsonResponse = convert.jsonDecode(encoded);
// // //     debugPrint("11111111000000");
// // //     navigateScreen(jsonResponse);
// // //
// // //   }
// // //
// // //   ///=========== navigate other screens==================================
// // //   static navigateScreen(var jsonResponse) async{
// // //     SharedPreferences prefs = await SharedPreferences.getInstance();
// // //     // Map<String, dynamic> jsonRe = jsonDecode(jsonResponse);
// // //     debugPrint("jsonRe.....${jsonResponse}");
// // //     Notifications model = Notifications.fromJson(jsonResponse);
// // //     debugPrint("model.....${model.type}");
// // //     // String senderName = jsonResponse['click_type'].toString();
// // //     // String id = jsonResponse['n_id'].toString();
// // //     String type = model.type.toString();
// // //     // try {
// // //     //   if ( clickType == "booking_cancelled_owner") {
// // //     //     navigatorKey.currentState?.push(MaterialPageRoute(
// // //     //       builder: (context) => PastReservationScreen(
// // //     //         model: null,
// // //     //         bookingId: id.toString(),
// // //     //         type: 'notification',
// // //     //         onUpdate: () {},
// // //     //       ),
// // //     //     ));
// // //     //   }
// // //     //   else if (clickType == "booking" || clickType == "booking_cancelled_user") {
// // //     //     LocalStorageServices.savingData("b_id", id.toString());
// // //     //     navigatorKey.currentState?.push(MaterialPageRoute(
// // //     //       builder: (context) =>  CalenderView(type: 'Notification', id: id,),
// // //     //     ));
// // //     //   }
// // //     //   else if (clickType == "chat") {
// // //     //     LocalStorageServices.savingData("n_id", id.toString());
// // //     //     LocalStorageServices.savingData("n_type", "Notification");
// // //     //     LocalStorageServices.savingData("r_name", jsonResponse['name'].toString());
// // //     //     LocalStorageServices.savingData("n_image",  ApiPath.imgBaseUrl +jsonResponse['image'].toString());
// // //     //     navigatorKey.currentState?.push(MaterialPageRoute(
// // //     //       builder: (context) => DashBoardScreen(tabIndex: 2,),
// // //     //     ));
// // //     //   }
// // //     //   else {
// // //     //     navigatorKey.currentState?.push(MaterialPageRoute(
// // //     //       builder: (context) => DashBoardScreen(),
// // //     //     ));
// // //     //   }
// // //     // } catch (e) {
// // //     //   debugPrint("Navigation error: $e");
// // //     // }
// // //     try {
// // //       if(type == "reminder"){
// // //         debugPrint("Type: afasfg");
// // //
// // //         navigatorKey.currentState?.pushAndRemoveUntil(
// // //           MaterialPageRoute(builder: (context) =>  BookingDetailMyBooking(selectedId: model.bookingId.toString(), onCallBack: onCallBack,)),
// // //               (route) => false,
// // //         );
// // //       }else{
// // //         debugPrint("ffff......");
// // //         navigatorKey.currentState?.pushAndRemoveUntil(
// // //           MaterialPageRoute(
// // //               builder: (context) => const Invitation(automaticallyImplyLeading: true, onCallBack: onCallBack, onCountUpdate: updateOnCallBack,)),
// // //               (route) => false,
// // //         );
// // //       }
// // //
// // //     } catch (e) {
// // //       debugPrint("Navigation error: $e");
// // //     }
// // //   }
// // //
// // //   static void display(RemoteMessage message) async {
// // //     try {
// // //       debugPrint('In Notification method');
// // //       debugPrint('>>>notificationData>>>>>${message.toString()}<<<<<<<<');
// // //       Random random = Random();
// // //       int id = random.nextInt(1000);
// // //       const NotificationDetails notificationDetails = NotificationDetails(
// // //         android: AndroidNotificationDetails(
// // //           "high_importance_channel",
// // //           "High Importance Notifications",
// // //           channelDescription: 'your channel description',
// // //           importance: Importance.high,
// // //           priority: Priority.max,
// // //           ticker: 'ticker' ,
// // //           icon: '@mipmap/ic_launcher',
// // //           playSound: true,
// // //         ),
// // //         iOS: DarwinNotificationDetails(
// // //           presentAlert: true,
// // //           presentBadge: false,
// // //           presentSound: true,
// // //           presentBanner: false,
// // //           // sound: "assets/images/sound.mp3"
// // //         ),
// // //       );
// // //       debugPrint('notification id is ${id.toString()}');
// // //       await _flutterLocalNotificationsPlugin.show(
// // //         id,
// // //         message.notification?.title ?? 'N/A',
// // //         message.notification?.body ?? 'N/A',
// // //         notificationDetails,
// // //         payload: message.data.toString(),
// // //       );
// // //       // handleMessage(message);
// // //     } on Exception catch (e) {
// // //       debugPrint('Error>>>$e');
// // //     }
// // //   }
// // //
// // //   static void onDidReceiveLocalNotification(
// // //       int id, String? title, String? body, String? payload) async {
// // //     debugPrint('Notification was receive: $title\nBody: $body\nPayload: $payload');
// // //     // FlutterRingtonePlayer.playNotification();
// // //     // display a dialog with the notification details, tap ok to go to another page
// // //     //handleMessage(payload);
// // //     debugPrint("4444");
// // //     Fluttertoast.showToast(msg: "msg....$title");
// // //   }
// // // }
// //
// import 'dart:io' show Platform;
// import 'dart:math';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:karigym/Utils/navigation_bar.dart';
// import 'package:karigym/custom_classes/custom_navigator.dart';
// import 'package:karigym/models/notification_payload_model.dart';
// import 'package:karigym/screen/home/booking_details_my_booking.dart';
// import 'package:karigym/screen/invitation/invitation_booking_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// bool? notificationsTitle = false;
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin
//   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   static void notificationTapBackground(message) {
//     _handleMessage(message);
//   }
//
//   static void initialize() async {
//
//     var messaging = FirebaseMessaging.instance;
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/notification_icon'),
//       iOS: DarwinInitializationSettings(
//         defaultPresentSound: true,
//         defaultPresentAlert: true,
//         defaultPresentBadge: true,
//         requestAlertPermission: true,
//         requestSoundPermission: true,
//         requestBadgePermission: true,
//       ),
//     );
//
//     await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//     _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(
//       const AndroidNotificationChannel(
//         "high_importance_channel",
//         "High Importance Notifications",
//         importance: Importance.max,
//         playSound: true,
//         enableVibration: true,
//         showBadge: true,
//       ),
//     );
//
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     try {
//       await FirebaseMessaging.instance.setAutoInitEnabled(true);
//       String? fcmToken;
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
//       fcmToken = await FirebaseMessaging.instance.getToken();
//
//       if (fcmToken?.isNotEmpty ?? false) {
//         prefs.setString("fcm_token", fcmToken.toString());
//         debugPrint('fcm token is>>${fcmToken.toString()}');
//       }
//       // ignore: empty_catches
//     } catch (e) {}
//
//     FirebaseMessaging.instance.getInitialMessage().then(
//           (message) {
//         /// This function is for app kill state
//
//         debugPrint(
//             'kill state >>> FirebaseMessaging.instance.getInitialMessage');
//         if (message != null) {
//           var notificationData = NotificationDataModel.fromJson(message.data);
//           _handleMessage(notificationData);
//           debugPrint('New Notification');
//         }
//       },
//     );
//
//     // FirebaseMessaging.onBackgroundMessage((message) async {
//     //   var notificationData = NotificationDataModel.fromJson(message.data);
//     //   _handleMessage(notificationData);
//     // });
//
//     FirebaseMessaging.onMessage.listen(
//           (message) {
//         /// This function is for foreground state
//         debugPrint('foreground >>> FirebaseMessaging.onMessage.listen');
//         debugPrint('data foreground is ${message.data.toString()}');
//         if (message.notification != null) {
//           debugPrint(
//               'message title on foreground is ${message.notification!.title}');
//           debugPrint(
//               'message body on foreground is ${message.notification!.body}');
//           debugPrint('message.data11 ${message.data}');
//           display(message);
//
//           _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//               onDidReceiveBackgroundNotificationResponse:
//               notificationTapBackground,
//               onDidReceiveNotificationResponse: (msg) {
//                 var notificationData = NotificationDataModel.fromJson(message.data);
//
//                 _handleMessage(notificationData);
//               });
//         }
//       },
//     );
//
//     FirebaseMessaging.onMessageOpenedApp.listen(
//           (message) {
//         /// This function is for background state
//
//         debugPrint(
//             'background >>>> FirebaseMessaging.onMessageOpenedApp.listen');
//         debugPrint('data background is ${message.data.toString()}');
//         var notificationData = NotificationDataModel.fromJson(message.data);
//         if (message.notification != null) {
//           debugPrint(
//               'message title on background is ${message.notification!.title}');
//           debugPrint(
//               'message body on background is ${message.notification!.body}');
//           _handleMessage(notificationData);
//           debugPrint("message.data22 ${message.data['_id']}");
//         }
//       },
//     );
//   }
//
//   static Future<bool> onCallBack(BuildContext context) async {
//     CustomNavigator.popNavigate(context);
//     // widget.onCallBack();
//     // setState(() {});
//     return true;
//   }
//
//   static void display(RemoteMessage message) async {
//     try {
//       debugPrint('In Notification method');
//       Random random = Random();
//       int id = random.nextInt(1000);
//       const NotificationDetails notificationDetails = NotificationDetails(
//         iOS: DarwinNotificationDetails(
//           presentSound: true,
//         ),
//         android: AndroidNotificationDetails(
//           "high_importance_channel",
//           "High Importance Notifications",
//           importance: Importance.max,
//           priority: Priority.high,
//           playSound: true,
//         ),
//       );
//       debugPrint('my id is ${id.toString()}');
//       await _flutterLocalNotificationsPlugin.show(
//         id,
//         message.notification?.title ?? 'N/A',
//         message.notification?.body ?? 'N/A',
//         notificationDetails,
//         payload: message.data['_id'],
//       );
//     } on Exception catch (e) {
//       debugPrint('Error>>>$e');
//     }
//   }
// }
//
//
// void _handleMessage(data) async {
//   debugPrint('clickAction>>> is ${data.clickAction.toString()}');
//   // debugPrint('orderId>>> is ${data.orderId.toString()}');
//   debugPrint('body>>> is ${data.body.toString()}');
//   String type = data.type.toString();
//   try {
//     if(type == "reminder"){
//       debugPrint("Type: afasfg");
//
//       navigatorKey.currentState?.push(
//         MaterialPageRoute(builder: (context) => BookingDetailMyBooking(selectedId: data.bookingId.toString(), onCallBack: (){},) ),
//       );
//     }else{
//       debugPrint("ffff......");
//       navigatorKey.currentState?.push(
//         MaterialPageRoute(
//             builder: (context) =>
//                 BookingDetailForInvitation(onCallBack: (){}, selectedId: data.bookingId.toString(), acceptReject: data.invitationId.toString())
//         ),
//       );
//     }
//
//   } catch (e) {
//     debugPrint("Navigation error: $e");
//   }
//
//   // if (data.orderId == null) {
//   //   // navigatorKey.currentState
//   //   //     ?.push(MaterialPageRoute(builder: (context) => const MyOrdersScreen()));
//   //   navigatorKey.currentState?.push(
//   //       MaterialPageRoute(builder: (context) => DashBordBottom()));
//   // } else if (data.orderId != null) {
//   //   /// Used pushAndRemoveUntil here because push navigates to Dashboard(0) after some seconds, to avoid this, used pushAndRemoveUntil
//   //   /// status: true, takes this because if we press back button of MyOrdersDetailsScreen, it will navigates to Dashboard(0) if status is true
//   //   navigatorKey.currentState?.pushAndRemoveUntil(
//   //     MaterialPageRoute(
//   //         builder: (context) => DashBordBottom()),
//   //         (route) => false,
//   //   );
//   // } else {
//   //   navigatorKey.currentState?.push(
//   //       MaterialPageRoute(builder: (context) => DashBordBottom()));
//   // }
//   //ISSUE BELOW
//   /// If using pushReplacement, myOrderScreen is visible perfect.
//   /// ISSUE If using push, myOrderScreen is visible for some seconds and then navigating to Dashboard(0) for some reason
// }
//
