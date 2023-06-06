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
    apiKey: 'AIzaSyDGbMo3fQGhqDqBkBEbRsHo0FQNUhY5DNE',
    appId: '1:1072402616853:web:b1a3393fe546dbe882b41c',
    messagingSenderId: '1072402616853',
    projectId: 'fir-test-9b2bd',
    authDomain: 'fir-test-9b2bd.firebaseapp.com',
    storageBucket: 'fir-test-9b2bd.appspot.com',
    measurementId: 'G-MDHKWFT3F8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQqANVeLTyzkwhQBZlkCHZawgGzhpO1r0',
    appId: '1:1072402616853:android:2e1b155a014b7e8882b41c',
    messagingSenderId: '1072402616853',
    projectId: 'fir-test-9b2bd',
    storageBucket: 'fir-test-9b2bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMCvm9gmIH_Xxm5ipIju2CmtHydDXyHs4',
    appId: '1:1072402616853:ios:ed749ac85e2c671e82b41c',
    messagingSenderId: '1072402616853',
    projectId: 'fir-test-9b2bd',
    storageBucket: 'fir-test-9b2bd.appspot.com',
    iosBundleId: 'com.example.moodin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMCvm9gmIH_Xxm5ipIju2CmtHydDXyHs4',
    appId: '1:1072402616853:ios:ed749ac85e2c671e82b41c',
    messagingSenderId: '1072402616853',
    projectId: 'fir-test-9b2bd',
    storageBucket: 'fir-test-9b2bd.appspot.com',
    iosBundleId: 'com.example.moodin',
  );
}
