import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rank_up/provider/AppProviders.dart';
import 'package:rank_up/services/local_storage.dart';
import 'package:rank_up/views/bottom_navigation_bar.dart';
import 'package:rank_up/views/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/app_localization_delegates.dart';
import 'Utils/notifiction_hendler.dart';
import 'firebase_options.dart';

NotificationServices notificationService = NotificationServices();
String deviceId = "";
String deviceType = "";
String fcmToken = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    AppProviders.init(
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      getId();
      pushFCMToken();
      notificationService.requestNotificationPermission();
      notificationService.setupInteractMessage(context);
      // Provider.of<DeviceProvider>(context, listen: false).initDeviceInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: MaterialApp(

        useInheritedMediaQuery: true,
        locale: _locale,
        supportedLocales: const [
          Locale('en', ''),
          // Locale('ar', ''),
        ],
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(
            dragHandleColor: Color(0xFFC4C6CE),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        home: SafeArea(
          top: false,
          child: SplashScreen(),
          // child: BottomNavController(initialIndex: 0),
        ),
      ),
    );
  }

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor!;
      deviceType = "ios";
      debugPrint("deviceId: $deviceId");
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
      deviceType = "android";
      debugPrint("deviceId: $deviceId");
      debugPrint("deviceType: $deviceType");
    }
    return null;
  }

  void pushFCMToken() async {
    try {
      String? token = await messaging.getToken();
      fcmToken = token ?? "";
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("fcmtoken", fcmToken);
      debugPrint("FCM Token: $fcmToken");
    } catch (e) {
      debugPrint("Error getting FCM token: $e");
    }
  }
}
