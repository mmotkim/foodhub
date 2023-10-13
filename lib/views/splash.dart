// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/api_auth_controller.dart';
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
  void dispose() {
    super.dispose();
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

    try {
      appState.init().then((value) {
        Future.delayed(
            const Duration(seconds: 2),
            () => {
                  if (appState.loggedIn)
                    {
                      if (appState.useFirebaseAuth)
                        {
                          if (appState.needMailVerify)
                            {
                              email = Provider.of<AuthController>(context, listen: false).getCurrentUser()!.email!,
                              _pushToEmailSent(email),
                            }
                          else //Firebase + email verified
                            {
                              context.router.replace(HomeRoute()),
                            }
                        }
                      else
                        {
                          //USING API AUTH
                          if (appState.needMailVerify)
                            {
                              email = Provider.of<ApiAuthController>(context, listen: false).getUserData()!.email,
                              _pushToEmailSent(email),
                            }
                          else //API + email verified
                            {context.router.replace(HomeRoute())}
                        }
                    }
                  else // NOT LOGGED IN
                    {context.router.replace(WelcomeRoute())}
                });
      });
    } catch (_) {
      print(_);
    }
  }

  Future<void> _pushToEmailSent(String email) async {
    await context.router.replaceAll([
      WelcomeRoute(),
      LoginRoute(),
      EmailSentRoute2(email: email, isLoggedIn: true),
    ]);
  }
}
