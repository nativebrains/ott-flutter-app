import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDg-SDOyKkIjJ7a1CQ3HL7dsRnnS-DUt9U',
    appId: '1:736086779059:android:2d90f9fd5b88000c503cc6',
    messagingSenderId: '736086779059',
    projectId: 'dawat-e-islami-ott-media',
    storageBucket: 'dawat-e-islami-ott-media.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxPI19AyyVpkp9kerrjQT0pgc6flw8nvA',
    appId: '1:736086779059:ios:bcc0029c4fd515ec503cc6',
    messagingSenderId: '736086779059',
    projectId: 'dawat-e-islami-ott-media',
    storageBucket: 'dawat-e-islami-ott-media.firebasestorage.app',
    iosClientId:
        '736086779059-3v9v8e8pbrutpg05ohctelpe2gn6elju.apps.googleusercontent.com',
    iosBundleId: 'com.dawateislami.islamforever',
  );
}
