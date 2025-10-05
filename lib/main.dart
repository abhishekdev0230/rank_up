import 'package:flutter/material.dart';
import 'package:rank_up/provider/AppProviders.dart';
import 'package:rank_up/services/local_storage.dart';
import 'package:rank_up/views/splash_view.dart';
import 'Utils/app_localization_delegates.dart';

// NotificationServices notificationService = NotificationServices();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogin = await StorageManager.readData(StorageManager.isLogin.toString()) ?? false;

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

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
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

        home: const SafeArea(
          top: false,
          child: SplashScreen(),
        ),
      ),
    );
  }
}
