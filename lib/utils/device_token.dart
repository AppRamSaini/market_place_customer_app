import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:market_place_customer/utils/exports.dart';

/// firebase token
deviceFCMToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: true,
      criticalAlert: true);

  String? firebaseToken;

  if (Platform.isIOS) {
    firebaseToken = await messaging.getAPNSToken();
    print("APNS Token: $firebaseToken");
  } else {
    firebaseToken = await messaging.getToken();
    print("FCM Token: $firebaseToken");
  }

  return firebaseToken;
}


