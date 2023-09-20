// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:foodhub/styles/custom_texts.dart';

class HorizontalSeparator extends StatelessWidget {
  const HorizontalSeparator({
    super.key,
    required this.color,
    required this.text,
  });
  final Color color;
  final String text;
  const HorizontalSeparator.dark()
      : this(color: const Color(0xFF5B5B5E), text: 'sign up with');
  const HorizontalSeparator.light()
      : this(color: Colors.white, text: 'Sign in with');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 0.5,
          width: 100.0,
          color: color,
        ),
        const SizedBox(width: 20.0),
        Text(
          text,
          style: CustomTextStyle.labelMedium(context).copyWith(color: color),
        ),
        const SizedBox(width: 10.0),
        Container(
          height: 0.5,
          width: 100.0,
          color: color,
        ),
      ],
    );
  }
}
