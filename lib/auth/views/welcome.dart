// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodhub/auth/views/login.dart';
import 'package:foodhub/auth/views/signup.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';

import '../../components/bottom_help_text.dart';

//Gesture
//seperate css for text

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
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'SofiaPro',
                  color: const Color(0xFF111719),
                  fontSize: 53,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
                children: const [
                  TextSpan(text: 'Welcome to\n'),
                  TextSpan(
                    text: 'FoodHub',
                    style: TextStyle(
                      color: Color(0xFFFE724C),
                      fontSize: 45,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 275.0,
            left: 30.0,
            child: SizedBox(
              width: 268,
              child: Text(
                'Your favourite foods delivered fast at your door.',
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
              child: HorizontalSeparator.light(),
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
                  children: const [
                    SocialButton.facebook(),
                    SocialButton.google(),
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
                    child: Text(
                      'Start with email or phone',
                      style: TextStyle(
                        color: Color(0xFFFEFEFE),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SofiaPro',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                BottomHelpText.welcome(onpressed: () {
                  Navigator.of(context).push(_createRoute(LoginScreen()));
                }),
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
