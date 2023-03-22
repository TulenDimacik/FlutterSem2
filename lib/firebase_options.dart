// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBmy6q7ZWrqOW0ma-UsSKZB6pDDn7fweFY',
    appId: '1:531890766965:web:97f9516c636cb73feb243c',
    messagingSenderId: '531890766965',
    projectId: 'fireflutter-d7bd2',
    authDomain: 'fireflutter-d7bd2.firebaseapp.com',
    storageBucket: 'fireflutter-d7bd2.appspot.com',
    measurementId: 'G-855QRW7WH3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXeNGWHqrtUY5X-IPUHdNS_Feo-3BYpA8',
    appId: '1:531890766965:android:0e38c9aa77b21e66eb243c',
    messagingSenderId: '531890766965',
    projectId: 'fireflutter-d7bd2',
    storageBucket: 'fireflutter-d7bd2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDghpb5hk3lBlnVWovcowUJI76naWHpa54',
    appId: '1:531890766965:ios:e3afc4c65a244b17eb243c',
    messagingSenderId: '531890766965',
    projectId: 'fireflutter-d7bd2',
    storageBucket: 'fireflutter-d7bd2.appspot.com',
    iosClientId: '531890766965-5c05tg44n7frg5u00telpll2d4oesqjm.apps.googleusercontent.com',
    iosBundleId: 'com.example.fireflutterr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDghpb5hk3lBlnVWovcowUJI76naWHpa54',
    appId: '1:531890766965:ios:e3afc4c65a244b17eb243c',
    messagingSenderId: '531890766965',
    projectId: 'fireflutter-d7bd2',
    storageBucket: 'fireflutter-d7bd2.appspot.com',
    iosClientId: '531890766965-5c05tg44n7frg5u00telpll2d4oesqjm.apps.googleusercontent.com',
    iosBundleId: 'com.example.fireflutterr',
  );
}