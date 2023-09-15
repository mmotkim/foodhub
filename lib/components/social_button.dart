// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.text,
    required this.iconPath,
  });
  final String text;
  final String iconPath;

  const SocialButton.facebook()
      : this(iconPath: 'assets/icons/fb.png', text: 'FACEBOOK');
  const SocialButton.google()
      : this(iconPath: 'assets/icons/gg.png', text: 'GOOGLE');

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Implement Google login
      },
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(150, 54),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black),
      icon: Image.asset(iconPath),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.7,
          fontFamily: 'SofiaPro',
        ),
      ),
    );
  }
}
