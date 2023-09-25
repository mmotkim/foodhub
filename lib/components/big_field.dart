// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:provider/provider.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';

import 'package:reactive_forms/reactive_forms.dart';

class BigField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final String label;
  final String formName;
  final TextEditingController controller;
  final Map<String, String Function(Object)>? validationMessages;

  const BigField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    this.textInputType = TextInputType.text,
    required this.label,
    required this.formName,
    required this.controller,
    this.validationMessages,
  }) : super(key: key);

  BigField.password({hintText, formName, controller, label})
      : this(
          hintText: hintText,
          obscureText: true,
          textInputType: TextInputType.text,
          label: label,
          formName: formName,
          controller: controller,
          validationMessages: InputValidation.passwordSignUpMap,
        );

  BigField.email({formName, controller, label})
      : this(
            hintText: 'example@mail.com',
            obscureText: false,
            textInputType: TextInputType.emailAddress,
            label: label,
            formName: formName,
            controller: controller,
            validationMessages: InputValidation.emailMap);

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
    _handleErrors(FormControl<Object?> control) {
      final firstError = control.errors.keys.first;
      widget.validationMessages?.forEach((key, value) {
        print(firstError);
        print('$key $value');
        if (key == firstError) {
          //pass error message to provider
          print('${value(firstError)} hi');
          print(value.call({}));
        } else {}
      });
      return false;
    }

    //core
    ReactiveTextField<Object?> reactiveTextField() {
      return ReactiveTextField(
        controller: widget.controller,
        formControlName: widget.formName,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText && !_passwordVisible,
        decoration: inputDeco(),
        textAlignVertical: TextAlignVertical.center,
        style: CustomTextStyle.fieldText,
        validationMessages: widget.validationMessages,
        showErrors: (control) => _handleErrors(control),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Label
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: CustomColors.label,
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
            child: reactiveTextField(),
          ),
        )
      ],
    );
  }

  InputDecoration inputDeco() {
    return InputDecoration(
      suffixIcon: !widget.obscureText
          ? null
          : IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
    );
  }
}
