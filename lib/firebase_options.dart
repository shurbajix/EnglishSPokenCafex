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
    apiKey: 'AIzaSyBTMpu8V83ylP2KUwux3XiV0bu7C4UONwY',
    appId: '1:257930519607:web:64c8704633123c2c6acbb2',
    messagingSenderId: '257930519607',
    projectId: 'english-spoken-cfae',
    authDomain: 'english-spoken-cfae.firebaseapp.com',
    storageBucket: 'english-spoken-cfae.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBZ-xXG9H2gNurU1m94FWJlECzBoo4mzQ',
    appId: '1:257930519607:android:55e4c452c4c1ce466acbb2',
    messagingSenderId: '257930519607',
    projectId: 'english-spoken-cfae',
    storageBucket: 'english-spoken-cfae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDX5oRDmeIBBiJ_E5dh798usJcT_v-p8JM',
    appId: '1:257930519607:ios:78a40394550729b86acbb2',
    messagingSenderId: '257930519607',
    projectId: 'english-spoken-cfae',
    storageBucket: 'english-spoken-cfae.appspot.com',
    iosClientId:
        '257930519607-q6t4qdmdaiog6cml07jm7fomo7dnc7qo.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDX5oRDmeIBBiJ_E5dh798usJcT_v-p8JM',
    appId: '1:257930519607:ios:78a40394550729b86acbb2',
    messagingSenderId: '257930519607',
    projectId: 'english-spoken-cfae',
    storageBucket: 'english-spoken-cfae.appspot.com',
    iosClientId:
        '257930519607-q6t4qdmdaiog6cml07jm7fomo7dnc7qo.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
