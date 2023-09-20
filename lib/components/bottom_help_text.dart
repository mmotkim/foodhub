// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/styles/custom_texts.dart';

class BottomHelpText extends StatefulWidget {
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
  final Color actionColor;
  final TextDecoration isUnderlined;
  final double? fontSize;
  final GestureTapCallback onPressed;

  const BottomHelpText.welcome({onpressed})
      : this(
          text: 'Already have an account? ',
          actionText: 'Sign in',
          color: Colors.white,
          actionColor: Colors.white,
          isUnderlined: TextDecoration.underline,
          fontSize: 16,
          onPressed: onpressed,
        );

  const BottomHelpText.light(
      {required String text,
      required String actionText,
      required GestureTapCallback onPressed})
      : this(
            text: text,
            actionText: actionText,
            color: const Color(0xFF5B5B5E),
            actionColor: const Color(0xFFFE724C),
            isUnderlined: TextDecoration.none,
            onPressed: onPressed);

  @override
  State<BottomHelpText> createState() => _BottomHelpTextState();
}

class _BottomHelpTextState extends State<BottomHelpText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: widget.fontSize != null
            ? CustomTextStyle.labelMedium(context).copyWith(
                color: widget.color,
                fontSize: widget.fontSize,
              )
            : CustomTextStyle.labelMedium(context).copyWith(
                color: widget.color,
              ),
        // style: TextStyle(
        //     fontSize: 14,
        //     fontFamily: 'SofiaPro',
        //     fontWeight: FontWeight.w400),
        children: [
          TextSpan(text: widget.text),
          TextSpan(
            text: widget.actionText,
            style: TextStyle(
                decoration: widget.isUnderlined,
                fontWeight: FontWeight.w500,
                color: widget.actionColor),
            recognizer: TapGestureRecognizer()..onTap = widget.onPressed,
          ),
        ],
      ),
    );
  }
}
