import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle labelMedium(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'SofiaPro',
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: const Color(0xFF9796A1),
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'SofiaPro',
        );
  }

  static TextStyle headlineLarge(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!.copyWith(
          fontSize: 36.41,
          fontWeight: FontWeight.w600,
          height: 1.2,
        );
  }
}
