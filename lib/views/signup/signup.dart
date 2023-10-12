// ignore_for_file: avoid_print, unused_import

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/controllers/error_controller.dart';
import 'package:foodhub/components/primary_button.dart';
import 'package:foodhub/components/secondary_button.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/styles/animated_routes.dart';
import 'package:foodhub/utils/form_utils.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/views/home_screen/home_screen.dart';
import 'package:foodhub/views/login/login.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:foodhub/views/phone_screen/phone.dart';
import 'package:foodhub/views/phoneVerification/phone_verify.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:foodhub/views/loading_screen/loading_screen.dart';
import 'package:another_flushbar/flushbar.dart';

import 'sign_up_form.dart';

//check responsiveness
//more customizable parameters for field

//submit button disableable X & added sign in
//multilanguage, used shared_preferences package for persisting package X
//custom colors X
//seperate validators X
//fix validation message location - new class for error messages - showError property in reactiveFormField - used onChanged instead - back to showError X
//setup user session X

//add google's X
//recode UX on auth X
//have lang detect device country on first startup X
//add phone authentication X
//fix UX on auth X
//reset password X
//code should expire
//4 chars code X

//dedicated router X
//recheck command for localization X -> add script for when building apk
//optional: get context locale without context X 
//fix google flow X
//user session X
//auto redirect on email_sent screen X
//replace loading screens X

//new reset password X
//preload splash background X
//existing routes in stack navigation X
//Add timeout for resend email X
//fix sign up with phone Xz
//block custom authed user from changing password X
//email verification ? -> REQUIRED after sign up with email/pass X (Added on after sign in + sign up with email/pass, splash screen)

//push notifications using firebase cloud messaging, 3 states
//sent localization msg without context X

//ask for push notificiation permission 
//FCM token for backend 
//don't just dispose fields when error 
//listen for email verification state on email sent screen 
//main menu design: remember state on changing drawers 

//flutter_secure_storage X
//prevent swiping back on home screen

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: signUpContent(context),
          ),
        ),
      ),
    );
  }

  List<Widget> signUpContent(BuildContext context) {
    return <Widget>[
      //Decoration
      _topDeco(),
      const SizedBox(height: 8.0),

      // Sign Up Heading Title
      _title(context),
      const SizedBox(height: 10),
      errorMessage(context),
      const SizedBox(height: 10.0),
      const SignUpForm(),
      const SizedBox(height: 20.0), // Spacing
      Center(
        child: BottomHelpText.light(
          text: '${'alreadyAccount'.tr()}?  ',
          actionText: 'login'.tr(),
          onPressed: () {
            context.router.navigate(const LoginRoute());
          },
        ),
      ),

      const SizedBox(height: 20.0), 
      // Spacing
      // Sign in with Text and Vertical Lines
      // HorizontalSeparator.dark(text: 'signUpWith'.tr()),
      // const SizedBox(height: 15.0), // Spacing
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 26.0),
      //   child: Row(
      //     children: [
      //       SocialButton.facebook(
      //         onPressed: () {},
      //       ),
      //       const SizedBox(
      //         width: 40,
      //       ),
      //       SocialButton.google(
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
      const SizedBox(height: 15),
      _continueWithPhone(context),
      const SizedBox(height: 28),
      _localeSwitcher(context)
    ];
  }

  Row _localeSwitcher(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () {
            context.setLocale(const Locale('en', 'US'));
          },
          child: const Text('English'),
        ),
        TextButton(
          onPressed: () {
            context.setLocale(const Locale('vi', 'VN'));
          },
          child: const Text('twat'),
        )
      ],
    );
  }

  Padding _continueWithPhone(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Row(
        children: [
          Expanded(
            child: SecondaryButton(
              text: LocaleKeys.continueWithPhone.tr(),
              onPressed: () {
                context.router.push(const PhoneRoute());
              },
              height: 60,
            ),
          ),
        ],
      ),
    );
  }

  Padding _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Text(
        'signUp',
        style: CustomTextStyle.headlineLarge(context),
      ).tr(),
      // child: Text(LocaleKeys.signIn.tr()),
    );
  }

  Container _topDeco() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.topDeco.provider(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Center errorMessage(BuildContext context) {
    return Center(
      child: Text(context.watch<AuthController>().errorMessage ?? '',
          style: CustomTextStyle.errorText(context)),
    );
  }
}

