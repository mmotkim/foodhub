// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class BigField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;

  const BigField({
    super.key,
    required this.hintText,
    required this.obscureText,
    this.textInputType = TextInputType.text,
  });

  const BigField.password()
      : this(
            hintText: 'A super secret password',
            obscureText: true,
            textInputType: TextInputType.text);

  const BigField.email()
      : this(
            hintText: 'example@mail.com',
            obscureText: false,
            textInputType: TextInputType.emailAddress);

  @override
  State<BigField> createState() => _BigFieldState();
}

class _BigFieldState extends State<BigField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Container(
          height: 65,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3ED3D1D8),
                blurRadius: 30,
                offset: Offset(15, 15),
                spreadRadius: 0,
              )
            ],
          ),
          child: TextField(
            keyboardType: widget.textInputType,
            obscureText: widget.obscureText && !_passwordVisible,
            decoration: InputDecoration(
              suffixIcon: !widget.obscureText
                  ? null
                  : IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xffD0D2D1),
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1.5,
                ),
              ),
              hintText: widget.hintText,
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
              fontFamily: 'SofiaPro',
            ),
          ),
        ),
      ),
    );
  }
}
