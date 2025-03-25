import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import '../core.dart';

abstract class PushNotificationService {
  Future initialize();
  Future updateFcmTokenFromUser();
}

class PushNotificationServiceImpl implements PushNotificationService {
  final AuthRepository repository;

  const PushNotificationServiceImpl({
    required this.repository,
  });

  @override
  Future initialize() async {
    await Firebase.initializeApp();
    print('FirebaseMessaging initialized');

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    print('Got a message whilst in the background!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }

  @override
  Future updateFcmTokenFromUser() async {
    try {
      final String? token = await FirebaseMessaging.instance.getToken();
      await repository.updateFcmToken(UpdateToken(
        token: token,
      ));
    } catch (_) {}
  }
}
