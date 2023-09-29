import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormSubmitButton extends StatelessWidget {
  const FormSubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
  });
  final String text;
  final GestureTapCallback onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return Container(
      width: 248,
      height: 60,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: form!.valid ? const Color(0x40FE724C) : Colors.transparent,
            blurRadius: 30,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: form.valid ? onPressed : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: const Color(0xFFFE724C).withOpacity(0.3),
          backgroundColor:
              const Color(0xFFFE724C), // Make the ElevatedButton transparent
          shadowColor: Colors.transparent, // Remove shadow
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'SofiaPro',
                letterSpacing: 1.20,
                color: form.valid
                    ? const Color(0xFFFEFEFE)
                    : const Color(0xFFFE724C).withOpacity(0.55),
              ),
        ),
      ),
    );
  }
}
