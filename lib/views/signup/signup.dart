// ignore_for_file: avoid_print, unused_import

import 'package:auto_route/auto_route.dart';
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
import 'package:foodhub/utils/system_controller.dart';
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
//add phone authentication X
//fix UX on auth X
//reset password X
//code should expire
//4 chars code X

//dedicated router X
//recheck command for localization X
//optional: get context locale without context
//fix google flow X
//user session X
//auto redirect on email_sent screen X
//replace loading screens X

//new reset password X
//preload splash background X
//existing routes in stack navigation X
//Add timeout for resend email X
//fix sign up with phone X
//block custom authed user from changing password X
//email verification ? -> REQUIRED after sign up with email/pass X (Added on after sign in + sign up with email/pass, splash screen)

@RoutePage()
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

  @override
  void dispose() {
    FormUtils.disposeAll(form);
    super.dispose();
  }

  //input validations
  final form = FormGroup({
    'name': InputValidation.name,
    'email': InputValidation.email,
    'password': InputValidation.password,
  });

  void _handleSignUp() async {
    final authProvider = Provider.of<AuthController>(context, listen: false);
    final systemController =
        Provider.of<SystemController>(context, listen: false);

    if (form.valid) {
      try {
        //get input
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final name = nameController.text.trim();
        print(email);

        //await firebase signup
        final result =
            await authProvider.signUp(context, email, password, name);
        print(result.user?.email);
        if (result.user != null && mounted) {
          await authProvider.sendEmailVerification(context).then((value) => {
                context.router.push(
                  EmailSentRoute2(email: email, isLoggedIn: true),
                )
              });
        }

        //clear message in case of return
        authProvider.clearErrorMessage();
      } on FirebaseAuthException catch (err) {
        systemController.handleFirebaseEx(err.code);
      } finally {
        form.controls.forEach((key, value) {
          value.updateValue('');
          value.markAsUntouched();
        });
      }
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
      _topDeco(),
      const SizedBox(height: 8.0),

      // Sign Up Heading Title
      _title(context),
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
            // Navigator.of(context)
            //     .push(AnimatedRoutes.slideRight(const LoginScreen()));
            context.router.navigate(const LoginRoute());
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
                  // Navigator.push(
                  //     context, AnimatedRoutes.slideRight(const PhoneScreen()));
                  context.router.push(const PhoneRoute());
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
