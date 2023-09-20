import 'package:flutter/material.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/primary_button.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';

//check responsiveness
//more customizable parameters for field
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Decorative Asset (Replace with your image)
                Container(
                  height: 80, // Adjust the height as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Assets.topDeco.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                // Sign Up Heading Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      fontFamily: 'SofiaPro',
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),

                // Full name field
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: SizedBox(
                    width: 108,
                    child: Text(
                      'Full name',
                      style: TextStyle(
                        color: Color(0xFF9796A1),
                        fontSize: 16,
                        fontFamily: 'Sofia Pro',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0), // Spacing
                const BigField(
                  hintText: 'First and Last name',
                  obscureText: false, //obscureText
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 18.0), // Spacing
                // Email Field
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: SizedBox(
                    width: 58,
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                        color: Color(0xFF9796A1),
                        fontSize: 16,
                        fontFamily: 'Sofia Pro',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0), // Spacing
                const BigField.email(),
                // Password Field
                const SizedBox(height: 18.0), // Spacing
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  child: SizedBox(
                    width: 73,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xFF9796A1),
                        fontSize: 16,
                        fontFamily: 'SofiaPro',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0), // Spacing
                const BigField.password(),
                // Sign-Up Button

                const SizedBox(height: 33.0), // Spacing

                const Center(
                  child: PrimaryButton(
                    text: 'SIGN UP',
                  ),
                ),

                //already have an account?
                const SizedBox(height: 20.0), // Spacing
                Center(
                  child: BottomHelpText.light(
                    text: 'Already have an account? ',
                    actionText: 'Login',
                    onPressed: () {},
                  ),
                ),

                const SizedBox(height: 20.0), // Spacing
                // Sign in with Text and Vertical Lines
                const HorizontalSeparator.dark(),
                const SizedBox(height: 20.0), // Spacing

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
