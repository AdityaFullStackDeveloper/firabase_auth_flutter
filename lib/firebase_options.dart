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
    apiKey: 'AIzaSyBEPGtM-3K9qYij53fBNzoV72lMXIbrwTI',
    appId: '1:947472091315:web:6ef12c6953e210994d48c6',
    messagingSenderId: '947472091315',
    projectId: 'fir-auth-d551f',
    authDomain: 'fir-auth-d551f.firebaseapp.com',
    storageBucket: 'fir-auth-d551f.appspot.com',
    measurementId: 'G-49V3PFYW9G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFur7o1fUK8qYWAVa2_dJ47Ir4tSQQWRI',
    appId: '1:947472091315:android:3d8ba5c1c811c1964d48c6',
    messagingSenderId: '947472091315',
    projectId: 'fir-auth-d551f',
    storageBucket: 'fir-auth-d551f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGHjdUw9Ie9i-lXxJkQYV7qj_3YWaDBcw',
    appId: '1:947472091315:ios:0f1ab547929992934d48c6',
    messagingSenderId: '947472091315',
    projectId: 'fir-auth-d551f',
    storageBucket: 'fir-auth-d551f.appspot.com',
    iosBundleId: 'com.example.firebaseAuthen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDGHjdUw9Ie9i-lXxJkQYV7qj_3YWaDBcw',
    appId: '1:947472091315:ios:0f1ab547929992934d48c6',
    messagingSenderId: '947472091315',
    projectId: 'fir-auth-d551f',
    storageBucket: 'fir-auth-d551f.appspot.com',
    iosBundleId: 'com.example.firebaseAuthen',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBEPGtM-3K9qYij53fBNzoV72lMXIbrwTI',
    appId: '1:947472091315:web:a57cb40084ab88324d48c6',
    messagingSenderId: '947472091315',
    projectId: 'fir-auth-d551f',
    authDomain: 'fir-auth-d551f.firebaseapp.com',
    storageBucket: 'fir-auth-d551f.appspot.com',
    measurementId: 'G-CBCMCZL1QK',
  );
}
