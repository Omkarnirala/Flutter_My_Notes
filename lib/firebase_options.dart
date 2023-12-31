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
    apiKey: 'AIzaSyDnyncYZZJVf98LtsFHSV2qRyxPUqgHuk8',
    appId: '1:187206294349:web:ee42a2e8698a3f9db73504',
    messagingSenderId: '187206294349',
    projectId: 'personal-note-s',
    authDomain: 'personal-note-s.firebaseapp.com',
    storageBucket: 'personal-note-s.appspot.com',
    measurementId: 'G-JP41LGSXEN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBZHkvW4VHiiRdOogLD7Xv8Q6HFUfSzS8',
    appId: '1:187206294349:android:f19486f9760b766cb73504',
    messagingSenderId: '187206294349',
    projectId: 'personal-note-s',
    storageBucket: 'personal-note-s.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFfpdA7JxYBDQVzN3LeY0ro2yVryz8wUs',
    appId: '1:187206294349:ios:68aa2dbe4a8d451bb73504',
    messagingSenderId: '187206294349',
    projectId: 'personal-note-s',
    storageBucket: 'personal-note-s.appspot.com',
    androidClientId: '187206294349-v05vg4tqb6bc3qc2eea1ooalh6a3imh5.apps.googleusercontent.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDFfpdA7JxYBDQVzN3LeY0ro2yVryz8wUs',
    appId: '1:187206294349:ios:4d6acabbdd183f6ab73504',
    messagingSenderId: '187206294349',
    projectId: 'personal-note-s',
    storageBucket: 'personal-note-s.appspot.com',
    androidClientId: '187206294349-v05vg4tqb6bc3qc2eea1ooalh6a3imh5.apps.googleusercontent.com',
    iosBundleId: 'com.example.notes.RunnerTests',
  );
}
