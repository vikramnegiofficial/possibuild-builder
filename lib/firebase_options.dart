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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDw0YFTQmgypx8e4aQhK_tKUtjHRjDUmhY',
    appId: '1:292128788128:web:934473c6f671c9a675c3c5',
    messagingSenderId: '292128788128',
    projectId: 'possibuild-i',
    authDomain: 'possibuild-i.firebaseapp.com',
    storageBucket: 'possibuild-i.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7i0BObnTNfjavIH7rEx9Va-K42-DGUvM',
    appId: '1:292128788128:android:039be7f7e70469a775c3c5',
    messagingSenderId: '292128788128',
    projectId: 'possibuild-i',
    storageBucket: 'possibuild-i.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaRiy-8-F2SjvU2MKNy5R65BOK56iSx7g',
    appId: '1:292128788128:ios:bc759e2db65b542075c3c5',
    messagingSenderId: '292128788128',
    projectId: 'possibuild-i',
    storageBucket: 'possibuild-i.appspot.com',
    iosClientId: '292128788128-unnpm2d1458klsgt7okv6ldcljmk3fd3.apps.googleusercontent.com',
    iosBundleId: 'com.example.possibuild',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaRiy-8-F2SjvU2MKNy5R65BOK56iSx7g',
    appId: '1:292128788128:ios:bc759e2db65b542075c3c5',
    messagingSenderId: '292128788128',
    projectId: 'possibuild-i',
    storageBucket: 'possibuild-i.appspot.com',
    iosClientId: '292128788128-unnpm2d1458klsgt7okv6ldcljmk3fd3.apps.googleusercontent.com',
    iosBundleId: 'com.example.possibuild',
  );
}