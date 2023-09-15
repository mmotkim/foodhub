// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/social_button.dart';

//minimize path to assets
//fix splash
//address warnings
//check responsiveness
//more customizable parameters for field
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Decorative Asset (Replace with your image)
              Container(
                height: 80, // Adjust the height as needed
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/topDeco.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 18.0), // Spacing
              BigField(
                hintText: 'First and Last name',
                obscureText: false, //obscureText
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
              const SizedBox(height: 18.0), // Spacing
              BigField(
                hintText: 'example@mail.com',
                obscureText: false,
              ),
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
                      fontFamily: 'Sofia Pro',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18.0), // Spacing
              BigField(
                hintText: 'A super secret password',
                obscureText: true,
              ),
              // Sign-Up Button

              const SizedBox(height: 20.0), // Spacing

              Center(
                child: Container(
                  width: 248,
                  height: 60,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFE724C),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x287A80BE),
                        blurRadius: 40,
                        offset: Offset(0, 10),
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .transparent, // Make the ElevatedButton transparent
                      shadowColor: Colors.transparent, // Remove shadow
                    ),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Color(0xFFFEFEFE),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Sofia Pro',
                      ),
                    ),
                  ),
                ),
              ),

              //already have an account?
              const SizedBox(height: 20.0), // Spacing
              Center(
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: TextStyle(
                      color: Color(0xFF5B5B5E),
                      fontSize: 14,
                      fontFamily: 'SofiaPro',
                    ),
                    children: const [
                      TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Color(0xFFFE724C),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20.0), // Spacing
              // Sign in with Text and Vertical Lines
              HorizontalSeparator.dark(),
              const SizedBox(height: 20.0), // Spacing

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.0),
                child: Center(
                  child: Row(
                    children: const [
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
    );
  }
}
