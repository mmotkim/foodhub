import 'package:flutter/material.dart';
import 'package:foodhub/auth/views/signup.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/primary_button.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../components/back_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void validateAndSave() {
    // setState(() {
    //   print("aaa ${passwordController.text}");
    // });
    // // final FormState form = _formKey.currentState!;
    // if (form.validate()) {
    //   // print('Form is valid');
    // } else {
    //   // print('Form is invalid');
    // }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => MainMemu(
    //             name: "test",
    //             email: emailController.text,
    //             password: passwordController.text,
    //           )),
    // );

    // Navigator.pushNamed(context, 'main_menu', arguments: {
    //   'email': emailController.text,
    //   'password': passwordController.text
    // });
  }

  final form = FormGroup({
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
    'password': FormControl<String>(validators: [
      Validators.required,
    ]),
  });

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
              children: [
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
                const SizedBox(height: 72.0),
                // Sign Up Heading Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    'Login',
                    style: CustomTextStyle.headlineLarge(context),
                  ),
                ),
                const SizedBox(height: 28.0),
                BigField.email(formName: 'email', controller: emailController),

                const SizedBox(height: 28.0),
                BigField.password(
                    formName: 'password', controller: passwordController),
                const SizedBox(height: 28),
                Center(
                  child: Column(
                    children: [
                      BottomHelpText.light(
                          text: '',
                          actionText: 'Forgot password?',
                          onPressed: () {}),
                      const SizedBox(height: 25),
                      PrimaryButton(
                        text: 'LOGIN',
                        onPressed: validateAndSave,
                      ),
                      const SizedBox(height: 20),
                      BottomHelpText.light(
                          text: 'Don\'t have an account? ',
                          actionText: 'Sign Up',
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                _createRoute(const SignUpScreen()));
                          }),
                      const SizedBox(height: 50),
                      const HorizontalSeparator.dark(),
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26),
                        child: Row(
                          children: [
                            SocialButton.facebook(),
                            SizedBox(width: 40),
                            SocialButton.google()
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                )
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
