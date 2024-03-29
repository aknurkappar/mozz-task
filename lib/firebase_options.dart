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
    apiKey: 'AIzaSyCnXSNolaQbvsMbgRdfY8iIb2ZWR4YesMI',
    appId: '1:531136759397:web:fc2e1792ecebb14c3d288c',
    messagingSenderId: '531136759397',
    projectId: 'mozz-task',
    authDomain: 'mozz-task.firebaseapp.com',
    storageBucket: 'mozz-task.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8FGKEcapjSN-vThVKwN5sUEmATQiMRaQ',
    appId: '1:531136759397:android:98eb77cb7f62f97b3d288c',
    messagingSenderId: '531136759397',
    projectId: 'mozz-task',
    storageBucket: 'mozz-task.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrD5Rm_CRyt-K1x6MJxgv0YKEiylXNvGs',
    appId: '1:531136759397:ios:c0376b72f5260a693d288c',
    messagingSenderId: '531136759397',
    projectId: 'mozz-task',
    storageBucket: 'mozz-task.appspot.com',
    iosBundleId: 'com.example.mozzTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBrD5Rm_CRyt-K1x6MJxgv0YKEiylXNvGs',
    appId: '1:531136759397:ios:76bd42615c5d6d223d288c',
    messagingSenderId: '531136759397',
    projectId: 'mozz-task',
    storageBucket: 'mozz-task.appspot.com',
    iosBundleId: 'com.example.mozzTask.RunnerTests',
  );
}
