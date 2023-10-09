// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFE724C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Assets.logo.image(
                width: 100,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Assets.brand.image(),
          ],
        ),
      ),
    );
  }

  Future<void> _init() async {
    final appState = Provider.of<ApplicationState>(context, listen: false);
    String email = '';
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);

    try {
      appState.init();
      Future.delayed(
          const Duration(seconds: 2),
          () => {
                if (appState.loggedIn)
                  {
                    if (appState.needMailVerify)
                      {
                        email =
                            Provider.of<AuthController>(context, listen: false)
                                .getCurrentUser()!
                                .email!,
                        context.router.replaceAll([
                          WelcomeRoute(),
                          LoginRoute(),
                          EmailSentRoute2(email: email, isLoggedIn: true),
                        ])
                      }
                    else
                      {
                        context.router.replace(HomeRoute()),
                      }
                  }
                else
                  {context.router.replace(WelcomeRoute())}
              });
    } catch (_) {
      print(_);
    }
  }
}
