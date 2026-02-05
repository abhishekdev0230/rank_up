// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ------------------- ANDROID -------------------
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1oB5yCDAx4N4g4Acbs-nwYt9h5ik-5Lc',
    // appId: '1:276170592360:android:707c569c5bacf9ff512bdd',
    appId: '1:276170592360:android:fac9bce56ce2f0fd512bdd',
    messagingSenderId: '276170592360',
    projectId: 'rankup-956b5',
    storageBucket: 'rankup-956b5.firebasestorage.app',
  );

  // ------------------- iOS -------------------
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY', // Replace from Firebase console → iOS app
    appId: 'YOUR_IOS_APP_ID', // Replace from Firebase console → iOS app
    messagingSenderId: '276170592360',
    projectId: 'rankup-956b5',
    storageBucket: 'rankup-956b5.firebasestorage.app',
    iosBundleId: 'com.rank_up',
  );

  // ------------------- WEB -------------------
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY', // Replace if using web
    appId: 'YOUR_WEB_APP_ID', // Replace if using web
    messagingSenderId: '276170592360',
    projectId: 'rankup-956b5',
    storageBucket: 'rankup-956b5.firebasestorage.app',
  );
}
