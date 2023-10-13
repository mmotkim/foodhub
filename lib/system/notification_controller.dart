import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/database/prefs_provider.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:rxdart/rxdart.dart';

class NotificationController {
  static Future<void> load() async {
    final messaging = FirebaseMessaging.instance;

    //AUTO RUN ONLY ON IOS
    NotificationSettings settings = await messaging.requestPermission(
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

    //listens for fcm token changes
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      debugPrint('FCM Token changed: $fcmToken');
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
      debugPrint('error on fcmToken listening $err');
    });

    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint(fcmToken);
  }

  static void foregroundListen(BehaviorSubject<RemoteMessage> messageStreamController) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Handling a foreground message: ${message.messageId}');
      debugPrint('Message data: ${message.data}');
      debugPrint('Message notification: ${message.notification?.title}');
      debugPrint('Message notification body: ${message.notification?.body}');

      messageStreamController.sink.add(message);
      EasyLoading.showInfo('${message.notification?.body}');
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    debugPrint("Handling a background message: ${message.messageId}");
    debugPrint('Message data: ${message.data}');
    debugPrint('Message notification: ${message.notification?.title}');
    debugPrint('Message notification body: ${message.notification?.body}');
  }

  // Future<void> terminatedHandler() async {
  //   print('terminated message:');
  //   await PrefsProvider.printCustom('terminated2');

  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage(); //terminated
  //   if (initialMessage != null) {
  //     await PrefsProvider.saveCustom('terminated2', initialMessage.notification.toString());
  //     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     //   context.router
  //     //       .push(EmailSentRoute2(email: 'pushed from bg msg ${initialMessage.toString()}', isLoggedIn: false));
  //     // });
  //   }
  // }

  static Future<void> terminatedhandler(BuildContext context) async {
    final terminatedMesssage = await PrefsProvider.getCustom('terminated2');
    if (terminatedMesssage != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.router.replaceAll([
          const LoginRoute(),
          EmailSentRoute2(email: 'terminated message: $terminatedMesssage', isLoggedIn: false),
        ]);
      });
    }
  }
}
