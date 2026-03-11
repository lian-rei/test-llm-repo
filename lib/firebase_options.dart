import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'your-api-key',
    appId: 'your-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'llm-test-53375',
    authDomain: 'llm-test-53375.firebaseapp.com',
    storageBucket: 'llm-test-53375.appspot.com',
    measurementId: 'your-measurement-id',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'your-api-key',
    appId: 'your-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'llm-test-53375',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-api-key',
    appId: 'your-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'llm-test-53375',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'your-api-key',
    appId: 'your-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'llm-test-53375',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'your-api-key',
    appId: 'your-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'llm-test-53375',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'your-api-key',
    appId: 'your-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'llm-test-53375',
  );
}