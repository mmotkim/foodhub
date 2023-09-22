// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:foodhub/styles/custom_colors.dart';

import 'package:reactive_forms/reactive_forms.dart';

class BigField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final String label;
  final String formName;
  final TextEditingController controller;

  const BigField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    this.textInputType = TextInputType.text,
    required this.label,
    required this.formName,
    required this.controller,
  }) : super(key: key);

  const BigField.password({hintText, formName, controller, label})
      : this(
            hintText: hintText,
            obscureText: true,
            textInputType: TextInputType.text,
            label: label,
            formName: formName,
            controller: controller);

  const BigField.email({formName, controller, label})
      : this(
            hintText: 'example@mail.com',
            obscureText: false,
            textInputType: TextInputType.emailAddress,
            label: label,
            formName: formName,
            controller: controller);

  @override
  State<BigField> createState() => _BigFieldState();
}

class _BigFieldState extends State<BigField> {
  bool _passwordVisible = false;
  // String _errorText = '';

  @override
  void initState() {
    super.initState();
    _passwordVisible = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Color(0xFF9796A1),
              fontSize: 16,
              fontFamily: 'SofiaPro',
            ),
          ),
        ),
        const SizedBox(height: 12.0), // Spacing

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Container(
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
            child: ReactiveTextField(
              controller: widget.controller,
              formControlName: widget.formName,
              keyboardType: widget.textInputType,
              obscureText: widget.obscureText && !_passwordVisible,
              validationMessages: {
                'required': (error) => 'This must not be empty!',
                'email': (error) => 'This must be a valid email address!',
              },
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
                focusColor: CustomColors.primary,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF0000),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: CustomColors.primary,
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
        )
      ],
    );
  }
}
