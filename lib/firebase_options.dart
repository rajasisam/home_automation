import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCxXIKYGWl7CWYaC9YXYVIKe61wx_cMEeM',
    appId: '1:628524237426:web:d13d522793d962eafa38eb',
    messagingSenderId: '628524237426',
    projectId: 'home-automation-58729',
    authDomain: 'home-automation-58729.firebaseapp.com',
    databaseURL: 'https://home-automation-58729-default-rtdb.firebaseio.com',
    storageBucket: 'home-automation-58729.appspot.com',
    measurementId: 'G-MEASUREMENT_ID'
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxXIKYGWl7CWYaC9YXYVIKe61wx_cMEeM',
    appId: '1:628524237426:android:d13d522793d962eafa38eb',
    messagingSenderId: '628524237426',
    projectId: 'home-automation-58729',
    databaseURL: 'https://home-automation-58729-default-rtdb.firebaseio.com',
    storageBucket: 'home-automation-58729.firebasestorage.app',
  );
}
