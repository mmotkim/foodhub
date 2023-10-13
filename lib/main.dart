// ignore_for_file: unused_import

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/auth/controllers/api_auth_controller.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/controllers/error_controller.dart';
import 'package:foodhub/database/prefs_provider.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/l10n/app_localizations.dart';
import 'package:foodhub/routes/app_router.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/system/notification_controller.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:foodhub/utils/load_image.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/views/loading_screen/loading_screen.dart';
import 'package:foodhub/views/login/login.dart';
import 'package:foodhub/views/signup/signup.dart';
import 'package:foodhub/views/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodhub/views/phoneVerification/phone_verify.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rxdart/rxdart.dart';

final _messageStreamController = BehaviorSubject<RemoteMessage>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");

  //Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Local Secure storage
  await PrefsProvider.load();

  //Notification
  NotificationController.load();

  NotificationController.foregroundListen(_messageStreamController); // foreground
  FirebaseMessaging.onBackgroundMessage(NotificationController.backgroundHandler); //background
  // NotificationController().terminatedHandler();
  // final RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  //preload images
  await loadInitialImages();

  //localization without context
  final t = await AppLocalizations.delegate.load(await PrefsProvider.getLocale() ?? const Locale('en'));
  debugPrint(t.helloWorld);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN'), Locale('en'), Locale('vi')],
      path: 'assets/i18n',
      fallbackLocale: const Locale('vi', 'VN'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthController()),
          ChangeNotifierProvider(create: (context) => ErrorController()),
          ChangeNotifierProvider(create: (context) => SystemController()),
          ChangeNotifierProvider(create: (context) => ApplicationState()),
          ChangeNotifierProvider(create: (context) => ApiAuthController())
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String _lastMessage = "";

  // _MyAppState() {
  //   //receiving foreground message, for UI changes
  //   _messageStreamController.listen((message) {
  //     setState(() {
  //       if (message.notification != null) {
  //         _lastMessage = 'Received a notification message:'
  //             '\nTitle=${message.notification?.title},'
  //             '\nBody=${message.notification?.body},'
  //             '\nData=${message.data}';
  //       } else {
  //         _lastMessage = 'Received a data message: ${message.data}';
  //       }
  //     });
  //   });
  // }

  Future<void> backgroundHandler() async {
    print('terminated message:');
    await PrefsProvider.printCustom('terminated2');

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage(); //terminated
    if (initialMessage != null) {
      await PrefsProvider.saveCustom('terminated2', initialMessage.data.toString());
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //   Future.delayed(const Duration(seconds: 5), () async {
      //     await context.router.push(const LoginRoute());
      //   });
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    backgroundHandler();
  }

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter FoodHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFE724C)),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFFE724C),
          selectionHandleColor: Color(0xFFFE724C),
        ),
        fontFamily: 'SofiaPro',
        useMaterial3: true,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: _appRouter.config(),
      builder: EasyLoading.init(),
    );
  }
}
