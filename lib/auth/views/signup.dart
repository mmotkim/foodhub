// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/views/login.dart';
import 'package:foodhub/components/back_button.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/primary_button.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:foodhub/auth/views/loading_screen.dart';

//check responsiveness
//more customizable parameters for field
//submit button disableable
//multilanguage
//add google's
//custom colors
//seperate validators
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  //input validations
  final form = FormGroup({
    'name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
    'password': FormControl<String>(validators: [
      Validators.required,
    ]),
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
        Navigator.of(context).push(_createRoute(const LoadingScreen()));

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
              children: <Widget>[
                // Decorative Asset (Replace with your image)
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
                const SizedBox(height: 8.0),
                // Sign Up Heading Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    'Sign Up',
                    style: CustomTextStyle.headlineLarge(context),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Full name field
                BigField(
                  hintText: 'First and Last name',
                  obscureText: false, //obscureText
                  textInputType: TextInputType.text,
                  label: 'Full name',
                  formName: 'name',
                  controller: nameController,
                ),
                const SizedBox(height: 18.0), // Spacing
                // Email Field
                BigField.email(
                  formName: 'email',
                  controller: emailController,
                ),
                // Password Field
                const SizedBox(height: 18.0), // Spacing
                BigField.password(
                  formName: 'password',
                  controller: passwordController,
                ),
                // Sign-Up Button
                const SizedBox(height: 33.0), // Spacing

                Center(
                  child: PrimaryButton(
                    text: 'SIGN UP',
                    onPressed: _handleSignUp,
                  ),
                ),

                //already have an account?
                const SizedBox(height: 20.0), // Spacing
                Center(
                  child: BottomHelpText.light(
                    text: 'Already have an account? ',
                    actionText: 'Login',
                    onPressed: () {
                      Navigator.of(context)
                          .push(_createRoute(const LoginScreen()));
                    },
                  ),
                ),

                const SizedBox(height: 50.0), // Spacing
                // Sign in with Text and Vertical Lines
                const HorizontalSeparator.dark(),
                const SizedBox(height: 15.0), // Spacing

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: Center(
                    child: Row(
                      children: [
                        SocialButton.facebook(),
                        SizedBox(
                          width: 40,
                        ),
                        SocialButton.google(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
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
