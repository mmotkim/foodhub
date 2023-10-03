// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/controllers/error_controller.dart';
import 'package:foodhub/utils/system_controller.dart';
import 'package:foodhub/views/loading_screen/loading_screen.dart';
import 'package:foodhub/views/main_menu.dart';
import 'package:foodhub/views/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodhub/views/phoneVerification/phone_verify.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // runApp(const MyApp());
  // runApp(ChangeNotifierProvider(
  //   create: (context) => AuthController(),
  //   builder: ((context, child) => const MyApp()),
  // ));
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/i18n',
      fallbackLocale: const Locale('vi', 'VN'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthController()),
          ChangeNotifierProvider(create: (context) => ErrorController()),
          ChangeNotifierProvider(create: (context) => SystemController()),
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      routes: {'main_menu': (context) => const MainMemu()},
      builder: EasyLoading.init(),
      home: const SplashScreen(),
    );
  }
}
