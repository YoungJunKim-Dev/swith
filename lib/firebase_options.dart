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
    apiKey: 'AIzaSyBLoSwHiHwC_A8BNa6j_4EhJhA5fMcB7R4',
    appId: '1:943929218726:web:312d582bdee3473b184667',
    messagingSenderId: '943929218726',
    projectId: 'swith-cd2b1',
    authDomain: 'swith-cd2b1.firebaseapp.com',
    storageBucket: 'swith-cd2b1.appspot.com',
    measurementId: 'G-VB6G9KW290',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHXc6nOrjRWlyIx0maYZoUcWl7bvSe9xk',
    appId: '1:943929218726:android:ed4b686ad8ea90c0184667',
    messagingSenderId: '943929218726',
    projectId: 'swith-cd2b1',
    storageBucket: 'swith-cd2b1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqGywEwpxtxNw3z-d496g3UOSJb8JdXKQ',
    appId: '1:943929218726:ios:cc039565f15b9b95184667',
    messagingSenderId: '943929218726',
    projectId: 'swith-cd2b1',
    storageBucket: 'swith-cd2b1.appspot.com',
    iosClientId: '943929218726-jntremp7e99ncgcqlara9u6cfu2gq9kt.apps.googleusercontent.com',
    iosBundleId: 'com.example.swith',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqGywEwpxtxNw3z-d496g3UOSJb8JdXKQ',
    appId: '1:943929218726:ios:89ef4c76bf325b6f184667',
    messagingSenderId: '943929218726',
    projectId: 'swith-cd2b1',
    storageBucket: 'swith-cd2b1.appspot.com',
    iosClientId: '943929218726-i566bv9cer7care9mqanrtsb32ilt90i.apps.googleusercontent.com',
    iosBundleId: 'com.example.swith.RunnerTests',
  );
}