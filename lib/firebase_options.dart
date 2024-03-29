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
    apiKey: 'AIzaSyBXfHK631wzTdab0zKtJ-Rg9AYoxC98Ri4',
    appId: '1:286885637466:web:71da217f77fa85cc299763',
    messagingSenderId: '286885637466',
    projectId: 'beer-e7c12',
    authDomain: 'beer-e7c12.firebaseapp.com',
    storageBucket: 'beer-e7c12.appspot.com',
    measurementId: 'G-T3D0C9T4M2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMb0nje7GiffOPaDtN5Lj_1WAl6C5AOhg',
    appId: '1:286885637466:android:4127867a6c9a60c8299763',
    messagingSenderId: '286885637466',
    projectId: 'beer-e7c12',
    storageBucket: 'beer-e7c12.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAoXEdOF9sNTvLZ5jNCmRqdx7TQM-szrmY',
    appId: '1:286885637466:ios:3245b44c50a1dd02299763',
    messagingSenderId: '286885637466',
    projectId: 'beer-e7c12',
    storageBucket: 'beer-e7c12.appspot.com',
    iosClientId: '286885637466-9q4rpo2bp6ng0dqvoj6q186nk68ep45h.apps.googleusercontent.com',
    iosBundleId: 'com.jmartin.ratingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAoXEdOF9sNTvLZ5jNCmRqdx7TQM-szrmY',
    appId: '1:286885637466:ios:3245b44c50a1dd02299763',
    messagingSenderId: '286885637466',
    projectId: 'beer-e7c12',
    storageBucket: 'beer-e7c12.appspot.com',
    iosClientId: '286885637466-9q4rpo2bp6ng0dqvoj6q186nk68ep45h.apps.googleusercontent.com',
    iosBundleId: 'com.jmartin.ratingApp',
  );
}
