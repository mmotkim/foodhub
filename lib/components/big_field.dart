// ignore_for_file: , no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import 'package:reactive_forms/reactive_forms.dart';

class BigField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final String? label;
  final String formName;
  final TextEditingController controller;
  final Map<String, String Function(Object)>? validationMessages;
  final Function? onChanged;
  final double? padding;

  const BigField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    this.textInputType = TextInputType.text,
    this.label,
    required this.formName,
    required this.controller,
    this.validationMessages,
    this.onChanged,
    this.padding,
  }) : super(key: key);

  BigField.password({hintText, formName, controller, label, onChanged})
      : this(
          hintText: hintText,
          obscureText: true,
          textInputType: TextInputType.text,
          label: label,
          formName: formName,
          controller: controller,
          validationMessages: InputValidation.passwordSignUpMap,
          onChanged: onChanged,
        );

  BigField.email({formName, controller, label, padding})
      : this(
            hintText: 'example@mail.com',
            obscureText: false,
            textInputType: TextInputType.emailAddress,
            label: label,
            formName: formName,
            controller: controller,
            validationMessages: InputValidation.emailMap,
            padding: padding);

  @override
  State<BigField> createState() => _BigFieldState();
}

class _BigFieldState extends State<BigField> {
  bool _passwordVisible = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _passwordVisible = !widget.obscureText;
  }

  clearError(FormControl<Object?> control) {
    if (control.valid) errorMessage = '';
  }

  _onChange(FormControl<Object?> control) {
    if (control.valid) setMessage('');
  }

  setMessage(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          errorMessage = message;
        }));
  }

  _handleErrors(FormControl<Object?> control) {
    //clear provider error message

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthController>().clearErrorMessage();
    });

    var firstError = control.errors.keys.firstWhereOrNull((element) => true);
    var _errorMessage = '';
    widget.validationMessages?.forEach((key, value) {
      clearError(control);
      if (key == firstError) {
        //pass error message to provider
        _errorMessage = value.call({});
      }
    });

    if (control.invalid && control.touched) {
      setMessage(_errorMessage);
    } else if (control.valid) {
      setMessage('');
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
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
        onChanged: (control) => _onChange(control),
        showErrors: (control) => _handleErrors(control),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Label
        _label(),
        const SizedBox(height: 12.0), // Spacing

        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      CustomColors.fieldShadow,
                    ]),
                child: reactiveTextField(),
              ),
              //error text
              _errorText()
            ],
          ),
        ),
      ],
    );
  }

  Padding _label() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Text(
        widget.label != null ? widget.label! : '',
        style: const TextStyle(
          color: CustomColors.label,
          fontSize: 16,
          fontFamily: 'SofiaPro',
        ),
      ),
    );
  }

  SizedBox _errorText() {
    return SizedBox(
      height: 10,
      child: Text(
        errorMessage,
        style: CustomTextStyle.errorFieldText(context),
        overflow: TextOverflow.visible,
      ),
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
      // errorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: const BorderSide(
      //     color: Color(0xFFFF0000),
      //   ),
      // ),
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
          color: errorMessage != ''
              ? const Color(0xFFFF0000)
              : Colors.grey.shade200,
          width: 1.5,
        ),
      ),
    );
  }
}
