// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/styles/custom_texts.dart';

class BottomHelpText extends StatelessWidget {
  const BottomHelpText({
    required this.text,
    required this.actionText,
    required this.color,
    required this.actionColor,
    required this.isUnderlined,
    this.fontSize,
    required this.onPressed,
  });
  final String text;
  final String actionText;
  final Color color;
  final Color? actionColor;
  final TextDecoration isUnderlined;
  final double? fontSize;
  final GestureTapCallback onPressed;

  const BottomHelpText.welcome(
      {required text, required actionText, required onpressed})
      : this(
          text: text,
          actionText: actionText,
          color: Colors.white,
          actionColor: Colors.white,
          isUnderlined: TextDecoration.underline,
          fontSize: 16,
          onPressed: onpressed,
        );

  const BottomHelpText.light(
      {required String text,
      required String actionText,
      required GestureTapCallback onPressed,
      fontSize,
      actionColor})
      : this(
          text: text,
          actionText: actionText,
          color: const Color(0xFF5B5B5E),
          actionColor: actionColor ?? CustomColors.primary,
          isUnderlined: TextDecoration.none,
          onPressed: onPressed,
          fontSize: fontSize,
        );

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: fontSize != null
            ? CustomTextStyle.labelMedium(context).copyWith(
                color: color,
                fontSize: fontSize,
              )
            : CustomTextStyle.labelMedium(context).copyWith(
                color: color,
              ),
        // style: TextStyle(
        //     fontSize: 14,
        //     fontFamily: 'SofiaPro',
        //     fontWeight: FontWeight.w400),
        children: [
          TextSpan(text: text),
          TextSpan(
            text: actionText,
            style: TextStyle(
                decoration: isUnderlined,
                fontWeight: FontWeight.w500,
                color: actionColor),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          ),
        ],
      ),
    );
  }
}
