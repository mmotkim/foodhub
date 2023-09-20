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
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'SofiaPro',
        );
  }
}
