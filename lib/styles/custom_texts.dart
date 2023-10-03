import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle errorFieldText(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'SofiaPro',
      color: Theme.of(context).colorScheme.error,
    );
  }

  static TextStyle labelMedium(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'SofiaPro',
    );
  }

  static TextStyle labellarge(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
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

  static TextStyle errorText(BuildContext context) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: 'SofiaPro',
      color: Theme.of(context).colorScheme.error,
    );
  }

  static TextStyle altLabel = const TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontFamily: 'SofiaPro',
    fontWeight: FontWeight.w600,
    height: 0,
    letterSpacing: 1.20,
  );

  static TextStyle fieldText = const TextStyle(
    color: Color(0xFF111719),
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'SofiaPro',
  );

  static TextStyle pinCode = const TextStyle(
    color: Color(0xFFFE724C),
    fontSize: 27.20,
    fontFamily: 'SofiaPro',
    fontWeight: FontWeight.w500,
    height: 0,
  );
}
