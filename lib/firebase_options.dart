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
    apiKey: 'AIzaSyBjbZAlG-frdp_WKfZCtcVRla81KIFHlOk',
    appId: '1:661938581763:web:119ad98e7ed842e6c47936',
    messagingSenderId: '661938581763',
    projectId: 'my-ecommerce-app-kengiray',
    authDomain: 'my-ecommerce-app-kengiray.firebaseapp.com',
    storageBucket: 'my-ecommerce-app-kengiray.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjbZAlG-frdp_WKfZCtcVRla81KIFHlOk',
    appId: '1:661938581763:android:119ad98e7ed842e6c47936',
    messagingSenderId: '661938581763',
    projectId: 'my-ecommerce-app-kengiray',
    storageBucket: 'my-ecommerce-app-kengiray.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBjbZAlG-frdp_WKfZCtcVRla81KIFHlOk',
    appId: '1:661938581763:web:119ad98e7ed842e6c47936',
    messagingSenderId: '661938581763',
    projectId: 'my-ecommerce-app-kengiray',
    authDomain: 'my-ecommerce-app-kengiray.firebaseapp.com',
    storageBucket: 'my-ecommerce-app-kengiray.firebasestorage.app',
  );
}
