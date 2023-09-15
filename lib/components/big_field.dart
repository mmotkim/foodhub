import 'package:flutter/material.dart';

class BigField extends StatelessWidget {
  const BigField({
    super.key,
    required this.hintText,
    required this.obscureText,
  });
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: SizedBox(
        height: 65,
        child: TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 1.5,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade300),
            contentPadding: const EdgeInsets.all(20),
            focusColor: const Color(0xFFFE724C),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFF0000),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFE724C),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFF0000),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0x197F7F7F),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 1.5,
              ),
            ),
          ),
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            color: Color(0xFF111719),
            fontSize: 17,
            fontWeight: FontWeight.w500,
            fontFamily: 'Sofia Pro',
          ),
        ),
      ),
    );
  }
}
