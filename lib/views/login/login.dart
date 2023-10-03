// ignore_for_file: unused_element, avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/styles/animated_routes.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/utils/system_controller.dart';
import 'package:foodhub/views/home_screen/home_screen.dart';
import 'package:foodhub/views/loading_screen/loading_screen.dart';
import 'package:foodhub/views/signup/signup.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../components/back_button.dart';
import '../reset_password/reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //clear error message on first render
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthController>().clearErrorMessage();
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final form = FormGroup({
    'email': InputValidation.email,
    'password': InputValidation.passwordLogin,
  });

  void _handleLogin() async {
    final authProvider = Provider.of<AuthController>(context, listen: false);
    final systemController =
        Provider.of<SystemController>(context, listen: false);
    if (form.valid) {
      try {
        //get input
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        print(email);

        //await firebase signup
        final result = await authProvider.signIn(context, email, password);
        // print(result.user?.email);
        if (result.user != null && mounted) {
          Navigator.push(
              context, AnimatedRoutes.slideRight(const HomeScreen()));
        }

        //clear message in case of return
        authProvider.clearErrorMessage();
      } on FirebaseAuthException catch (e) {
        systemController.handleFirebaseEx(e.code);
      } finally {
        Future.delayed(
            const Duration(milliseconds: 1500), () => EasyLoading.dismiss());
      }
    } else {
      print('form is shit');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: loginContent(context),
            ),
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
      errorMessage(context),
      const SizedBox(height: 14.0),
      BigField.email(
        formName: 'email',
        controller: emailController,
        label: LocaleKeys.email.tr(),
      ),

      const SizedBox(height: 28.0),
      BigField.password(
        hintText: LocaleKeys.passGuide.tr(),
        formName: 'password',
        controller: passwordController,
        label: LocaleKeys.pass.tr(),
      ),
      const SizedBox(height: 28),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BottomHelpText.light(
                text: '',
                actionText: '${LocaleKeys.forgotPassword.tr()}?',
                onPressed: () {
                  Navigator.of(context).push(
                      AnimatedRoutes.slideRight(const ResetPasswordScreen()));
                }),
            const SizedBox(height: 25),
            FormSubmitButton(
              text: LocaleKeys.login.tr().toUpperCase(),
              onPressed: _handleLogin,
            ),
            const SizedBox(height: 20),
            BottomHelpText.light(
                text: '${LocaleKeys.dontAccount.tr()}?  ',
                actionText: LocaleKeys.signUp.tr(),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      AnimatedRoutes.slideRight(const SignUpScreen()));
                }),
            const SizedBox(height: 50),
            HorizontalSeparator.dark(text: LocaleKeys.signInWith.tr()),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  SocialButton.facebook(
                    onPressed: () {},
                  ),
                  const SizedBox(width: 40),
                  SocialButton.google(
                    onPressed: () {},
                  )
                ],
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      )
    ];
  }

  Widget errorMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Center(
        child: Text(context.watch<AuthController>().errorMessage ?? '',
            style: CustomTextStyle.errorText(context)),
      ),
    );
  }
}
