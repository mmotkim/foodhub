import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/views/main_menu.dart';
import 'package:foodhub/auth/views/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const MyApp());
  // runApp(ChangeNotifierProvider(
  //   create: (context) => AuthController(),
  //   builder: ((context, child) => const MyApp()),
  // ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (error) => 'This must not be empty',
        ValidationMessage.email: (error) => 'This is not a valid email',
      },
      child: MaterialApp(
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
        routes: {'main_menu': (context) => const MainMemu()},
        home: const SplashScreen(),
      ),
    );
  }
}
