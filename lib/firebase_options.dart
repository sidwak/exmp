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
    apiKey: 'AIzaSyB4Q5BBiWgQ2qCVDsMrAIEi992Pozy50w4',
    appId: '1:724378968368:web:16e4d2f12f01698b4468f5',
    messagingSenderId: '724378968368',
    projectId: 'exmp-8314b',
    authDomain: 'exmp-8314b.firebaseapp.com',
    storageBucket: 'exmp-8314b.appspot.com',
    measurementId: 'G-YSKDB9L7M3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsDdBYt0v6mIv4rBhFqlSIq6bjXdupAas',
    appId: '1:724378968368:android:6e8dea338a4a0c704468f5',
    messagingSenderId: '724378968368',
    projectId: 'exmp-8314b',
    storageBucket: 'exmp-8314b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcecJ8IFLbkpjNgwsX4qp1o0Lvb9OCmck',
    appId: '1:724378968368:ios:ba2bc21268d2fa274468f5',
    messagingSenderId: '724378968368',
    projectId: 'exmp-8314b',
    storageBucket: 'exmp-8314b.appspot.com',
    iosBundleId: 'com.example.exmp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcecJ8IFLbkpjNgwsX4qp1o0Lvb9OCmck',
    appId: '1:724378968368:ios:d47e5838cd6527634468f5',
    messagingSenderId: '724378968368',
    projectId: 'exmp-8314b',
    storageBucket: 'exmp-8314b.appspot.com',
    iosBundleId: 'com.example.exmp.RunnerTests',
  );
}
