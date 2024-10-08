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
    apiKey: 'AIzaSyBEzD2a9DeT-Neid1_-xRkNu97lXH6tXv0',
    appId: '1:610008552642:web:8c9d3281ae239d8369575b',
    messagingSenderId: '610008552642',
    projectId: 'fir-authentication-demo-beab5',
    authDomain: 'fir-authentication-demo-beab5.firebaseapp.com',
    storageBucket: 'fir-authentication-demo-beab5.appspot.com',
    measurementId: 'G-KC145CWDQF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAcllbDvPtlC6D13HJMC610bbfMrt8ToU',
    appId: '1:610008552642:android:fc7bc4188f12346269575b',
    messagingSenderId: '610008552642',
    projectId: 'fir-authentication-demo-beab5',
    storageBucket: 'fir-authentication-demo-beab5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDg_25x4y3d9w5KuCBFC9XsUTSArVeMrQ',
    appId: '1:610008552642:ios:196b59c75a772fdf69575b',
    messagingSenderId: '610008552642',
    projectId: 'fir-authentication-demo-beab5',
    storageBucket: 'fir-authentication-demo-beab5.appspot.com',
    iosBundleId: 'com.example.firebaseAuthenticationDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDg_25x4y3d9w5KuCBFC9XsUTSArVeMrQ',
    appId: '1:610008552642:ios:0c154f74223b242469575b',
    messagingSenderId: '610008552642',
    projectId: 'fir-authentication-demo-beab5',
    storageBucket: 'fir-authentication-demo-beab5.appspot.com',
    iosBundleId: 'com.example.firebaseAuthenticationDemo.RunnerTests',
  );
}
