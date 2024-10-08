// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBblqaxZolVEOTFs2OMUKR08YZDfSTO3D8',
    appId: '1:229542730082:web:38fe0e788217ec2fdcf43b',
    messagingSenderId: '229542730082',
    projectId: 'gomate-d9ae0',
    authDomain: 'gomate-d9ae0.firebaseapp.com',
    storageBucket: 'gomate-d9ae0.appspot.com',
    measurementId: 'G-WZBN5R4XPS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCylw4U60qZWE7GNkMcRG6MlZZk4EY8keY',
    appId: '1:229542730082:android:631d56e3299d98f6dcf43b',
    messagingSenderId: '229542730082',
    projectId: 'gomate-d9ae0',
    storageBucket: 'gomate-d9ae0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIwfk_SohXkQfSizOUDBDyD3CJT8fhMcQ',
    appId: '1:229542730082:ios:50d676f0a03b17b5dcf43b',
    messagingSenderId: '229542730082',
    projectId: 'gomate-d9ae0',
    storageBucket: 'gomate-d9ae0.appspot.com',
    iosBundleId: 'com.example.gomate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIwfk_SohXkQfSizOUDBDyD3CJT8fhMcQ',
    appId: '1:229542730082:ios:50d676f0a03b17b5dcf43b',
    messagingSenderId: '229542730082',
    projectId: 'gomate-d9ae0',
    storageBucket: 'gomate-d9ae0.appspot.com',
    iosBundleId: 'com.example.gomate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBblqaxZolVEOTFs2OMUKR08YZDfSTO3D8',
    appId: '1:229542730082:web:b4a6639f8f75492ddcf43b',
    messagingSenderId: '229542730082',
    projectId: 'gomate-d9ae0',
    authDomain: 'gomate-d9ae0.firebaseapp.com',
    storageBucket: 'gomate-d9ae0.appspot.com',
    measurementId: 'G-1J1R83H0JB',
  );
}