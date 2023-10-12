import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

class NotificationController {
  static void foregroundListen(
      BehaviorSubject<RemoteMessage> _messageStreamController) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification body: ${message.notification?.body}');

      _messageStreamController.sink.add(message);
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification body: ${message.notification?.body}');
  }
}
