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
    apiKey: 'AIzaSyDnyyM0QZzxL5bcbqLL34vcK3_6Nkw4jrQ',
    appId: '1:1057168250517:web:43308f5afd67efec64ad9c',
    messagingSenderId: '1057168250517',
    projectId: 'tele-doc-ed764',
    authDomain: 'tele-doc-ed764.firebaseapp.com',
    storageBucket: 'tele-doc-ed764.appspot.com',
    measurementId: 'G-P2MRZZQ805',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHPB8HjPsxaRN8BQDCbrGQyxlGDG0nxJY',
    appId: '1:1057168250517:android:a8b7633b9d4081a164ad9c',
    messagingSenderId: '1057168250517',
    projectId: 'tele-doc-ed764',
    storageBucket: 'tele-doc-ed764.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGlYnq7kLUn_KNV8lEyJFlbeyt_RclUpc',
    appId: '1:1057168250517:ios:c294b5b8a6b529a264ad9c',
    messagingSenderId: '1057168250517',
    projectId: 'tele-doc-ed764',
    storageBucket: 'tele-doc-ed764.appspot.com',
    iosBundleId: 'com.example.teledocuser',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGlYnq7kLUn_KNV8lEyJFlbeyt_RclUpc',
    appId: '1:1057168250517:ios:c294b5b8a6b529a264ad9c',
    messagingSenderId: '1057168250517',
    projectId: 'tele-doc-ed764',
    storageBucket: 'tele-doc-ed764.appspot.com',
    iosBundleId: 'com.example.teledocuser',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDnyyM0QZzxL5bcbqLL34vcK3_6Nkw4jrQ',
    appId: '1:1057168250517:web:6a464f5619b4e44e64ad9c',
    messagingSenderId: '1057168250517',
    projectId: 'tele-doc-ed764',
    authDomain: 'tele-doc-ed764.firebaseapp.com',
    storageBucket: 'tele-doc-ed764.appspot.com',
    measurementId: 'G-D8X4RX5HN4',
  );

}