// ignore_for_file: avoid_print, unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/controllers/error_controller.dart';
import 'package:foodhub/components/primary_button.dart';
import 'package:foodhub/components/secondary_button.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/styles/animated_routes.dart';
import 'package:foodhub/views/login/login.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:foodhub/views/verification/verification.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:foodhub/views/loading_screen/loading_screen.dart';
import 'package:another_flushbar/flushbar.dart';

//check responsiveness
//more customizable parameters for field

//submit button disableable X & added sign in
//multilanguage, used shared_preferences package for persisting package X
//custom colors X
//seperate validators X
//fix validation message location - new class for error messages - showError property in reactiveFormField - used onChanged instead - back to showError X
//setup user session
//add google's X
//recode UX on auth X
//have lang detect device country on first startup X

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthController>().clearErrorMessage();
    });
  }

  //input validations
  final form = FormGroup({
    'name': InputValidation.name,
    'email': InputValidation.email,
    'password': InputValidation.password,
  });

  void _handleSignUp() async {
    final authProvider = Provider.of<AuthController>(context, listen: false);

    if (form.valid) {
      try {
        //get input
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final name = nameController.text.trim();
        print(email);

        //go to loading screen
        Navigator.of(context).push(AnimatedRoutes.slideRight(LoadingScreen(
          loadingMessage: LocaleKeys.authLoadingMessageSignUp.tr(),
          loadedMessage: LocaleKeys.signUpComplete.tr(),
        )));

        //await firebase signup
        final result = await authProvider.signUp(email, password, name);
        print(result.user?.email);

        //clear message in case of return
        authProvider.clearErrorMessage();
      } catch (err) {
        print('Error during sign-up: $err');
      } finally {}
    } else {
      print('form is shit');

      print(form.errors);
      form.errors.forEach((key, value) {
        print('$key $value');
      });
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
              children: signUpContent(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> signUpContent(BuildContext context) {
    return <Widget>[
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
      const SizedBox(height: 8.0),

      // Sign Up Heading Title
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Text(
          'signUp',
          style: CustomTextStyle.headlineLarge(context),
        ).tr(),
        // child: Text(LocaleKeys.signIn.tr()),
      ),
      const SizedBox(height: 10),
      errorMessage(context),
      const SizedBox(height: 10.0),
      // Full name field
      BigField(
        hintText: 'nameGuide'.tr(),
        obscureText: false, //obscureText
        textInputType: TextInputType.text,
        label: 'fullName'.tr(),
        formName: 'name',
        controller: nameController,
        validationMessages: InputValidation.nameMap,
      ),
      const SizedBox(height: 18.0), // Spacing
      // Email Field
      BigField.email(
        formName: 'email',
        controller: emailController,
        label: 'email'.tr(),
      ),
      // Password Field
      const SizedBox(height: 18.0), // Spacing
      BigField.password(
        hintText: 'passGuide'.tr(),
        formName: 'password',
        controller: passwordController,
        label: 'pass'.tr(),
      ), // Sign-Up Button
      const SizedBox(height: 33.0), // Spacing

      Center(
        child: FormSubmitButton(
          text: 'signUp'.tr().toUpperCase(),
          onPressed: _handleSignUp,
        ),
      ),

      //already have an account?
      const SizedBox(height: 20.0), // Spacing
      Center(
        child: BottomHelpText.light(
          text: '${'alreadyAccount'.tr()}?  ',
          actionText: 'login'.tr(),
          onPressed: () {
            Navigator.of(context)
                .push(AnimatedRoutes.slideRight(const LoginScreen()));
          },
        ),
      ),

      const SizedBox(height: 20.0), // Spacing
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Row(
          children: [
            Expanded(
              child: SecondaryButton(
                text: 'Continue with phone number',
                onPressed: () {
                  Navigator.push(context,
                      AnimatedRoutes.slideRight(const VerificationScreen()));
                },
                height: 60,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 28),
      Row(
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
      )
    ];
  }

  Center errorMessage(BuildContext context) {
    return Center(
      child: Text('${context.watch<AuthController>().errorMessage ?? ''}',
          style: CustomTextStyle.errorText(context)),
    );
  }
}
