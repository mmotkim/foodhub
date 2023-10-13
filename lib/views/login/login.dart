// ignore_for_file: unused_element, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/views/login/login_form.dart';
import '../../components/back_button.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  //clear error message on first render
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: loginContent(context),
          ),
        ),
      ),
    );
  }

  List<Widget> loginContent(BuildContext context) {
    return <Widget>[
      Stack(
        children: [
          //Decoration
          Container(
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.topDeco.provider(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //Back button
          const NavPopButton(),
        ],
      ),
      const SizedBox(height: 42.0),

      // Sign Up Heading Title
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Text(
          LocaleKeys.login.tr(),
          style: CustomTextStyle.headlineLarge(context),
        ),
      ),
      const SizedBox(height: 14),
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginForm(),
            SizedBox(height: 28),
          ],
        ),
      )
    ];
  }
}
