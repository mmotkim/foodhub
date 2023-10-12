import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class NotificationController {
  static Future<void> load() async {
    final _messaging = FirebaseMessaging.instance;

    //AUTO RUN ONLY ON IOS
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }

    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint(fcmToken);
  }

  static void foregroundListen(BehaviorSubject<RemoteMessage> _messageStreamController) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Handling a foreground message: ${message.messageId}');
      debugPrint('Message data: ${message.data}');
      debugPrint('Message notification: ${message.notification?.title}');
      debugPrint('Message notification body: ${message.notification?.body}');

      _messageStreamController.sink.add(message);
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    debugPrint("Handling a background message: ${message.messageId}");
    debugPrint('Message data: ${message.data}');
    debugPrint('Message notification: ${message.notification?.title}');
    debugPrint('Message notification body: ${message.notification?.body}');
  }
}
