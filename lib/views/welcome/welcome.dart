// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/views/login/login.dart';
import 'package:foodhub/views/signup/signup.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:provider/provider.dart';

import '../../components/bottom_help_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Assets.images.welcomeBG.provider(), fit: BoxFit.cover),
            ),
          ),
          //skip button
          Positioned(
            right: 20,
            top: 10,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(fixedSize: Size(76, 32)),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Color(0xFFFE724C),
                  fontSize: 14,
                  fontFamily: 'SofiaPro',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          //title
          Positioned(
            top: 140.0,
            left: 30.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: RichText(
                softWrap: true,
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: context.locale.languageCode == 'en'
                      ? TextStyle(
                          fontFamily: 'SofiaPro',
                          color: const Color(0xFF111719),
                          fontSize: 53,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        )
                      : TextStyle(
                          fontFamily: 'SofiaPro',
                          color: const Color(0xFF111719),
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                  children: [
                    TextSpan(text: 'welcomeTo'.tr()),
                    TextSpan(
                      text: ' \nFoodHub',
                      style: TextStyle(
                        color: Color(0xFFFE724C),
                        fontSize: 45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 275.0,
            left: 30.0,
            child: SizedBox(
              width: 268,
              child: Text(
                'welcomeBody'.tr(),
                style: TextStyle(
                    color: Color(0xFF2F384E),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    fontFamily: 'SofiaPro',
                    shadows: [
                      Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 5))
                    ]),
              ),
            ),
          ),

          // Sign in with Text and Vertical Lines
          Positioned(
            bottom: 215.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: HorizontalSeparator.light(text: 'signInWith'.tr()),
            ),
          ),
          // Login Buttons at the Bottom
          Positioned(
            bottom: 25.0,
            left: 28.0,
            right: 28.0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SocialButton.facebook(
                      onPressed: () {},
                    ),
                    SocialButton.google(
                      onPressed: () {
                        final authController =
                            Provider.of<AuthController>(context, listen: false);
                        authController.signInWithGoogle(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 23,
                ),
                Container(
                  width: 345,
                  height: 54,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color(0x35FFFFFF),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(_createRoute(SignUpScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .transparent, // Make the ElevatedButton transparent
                      shadowColor: Colors.transparent, // Remove shadow
                    ),
                    child: Text('signInEmail'.tr(),
                        style: context.locale.languageCode == 'en'
                            ? TextStyle(
                                color: Color(0xFFFEFEFE),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SofiaPro',
                              )
                            : TextStyle(
                                color: Color(0xFFFEFEFE),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SofiaPro',
                              )),
                  ),
                ),
                SizedBox(height: 25),
                BottomHelpText.welcome(
                  onpressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  text: '${'alreadyAccount'.tr()}?  ',
                  actionText: 'signIn'.tr(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
