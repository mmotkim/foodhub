// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:provider/provider.dart';

import '../../components/bottom_help_text.dart';

@RoutePage()
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

  Future<void> _onGoogle() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    final systemController = context.read<SystemController>();
    try {
      systemController.showLoading();
      await authController.signInWithGoogle(context).then((value) => {
            systemController.showSuccess('Welcome Back'),
            context.router.push(HomeRoute()),
          });
    } catch (_) {
      systemController.showError('Something went wrong');
      print('mother fucker!$_');
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _welcomeBG(),
          //skip button
          _skipButton(),
          _title(context),
          _body(),

          // Sign in with
          Positioned(
            bottom: 215.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: HorizontalSeparator.light(text: 'signInWith'.tr()),
            ),
          ),
          // Login Buttons
          Positioned(
            bottom: 25.0,
            left: 28.0,
            right: 28.0,
            child: Column(
              children: [
                _socialButtons(context),
                SizedBox(height: 23),
                _signInEmail(context),
                SizedBox(height: 25),
                BottomHelpText.welcome(
                  onpressed: () {
                    // Navigator.of(context).pushNamed('/login');
                    context.router.push(LoginRoute());
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

  Container _welcomeBG() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Assets.images.welcomeBG.provider(), fit: BoxFit.cover),
      ),
    );
  }

  Positioned _skipButton() {
    return Positioned(
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
    );
  }

  Container _signInEmail(BuildContext context) {
    return Container(
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
          // Navigator.of(context).push(_createRoute(SignUpScreen()));
          context.router.push(SignUpRoute());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.transparent, // Make the ElevatedButton transparent
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
    );
  }

  Row _socialButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SocialButton.facebook(
          onPressed: () {},
        ),
        SocialButton.google(
          onPressed: _onGoogle,
        ),
      ],
    );
  }

  Positioned _body() {
    return Positioned(
      top: 275.0,
      left: 30.0,
      child: SizedBox(
        width: 268,
        child: Text(
          LocaleKeys.welcomeBody.tr(),
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
    );
  }

  Positioned _title(BuildContext context) {
    return Positioned(
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
    );
  }
}
