// ignore_for_file: avoid_print, unused_import

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/controllers/error_controller.dart';
import 'package:foodhub/components/primary_button.dart';
import 'package:foodhub/components/secondary_button.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/styles/animated_routes.dart';
import 'package:foodhub/utils/form_utils.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/views/home_screen/home_screen.dart';
import 'package:foodhub/views/login/login.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:foodhub/views/phone_screen/phone.dart';
import 'package:foodhub/views/phoneVerification/phone_verify.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:foodhub/views/loading_screen/loading_screen.dart';
import 'package:another_flushbar/flushbar.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthController>().clearErrorMessage();
    });
  }

  @override
  void dispose() {
    FormUtils.disposeAll(form);
    super.dispose();
  }

  //input validations
  final form = FormGroup({
    'name': InputValidation.name,
    'email': InputValidation.email,
    'password': InputValidation.password,
  });

  void _handleSignUp() async {
    final authProvider = Provider.of<AuthController>(context, listen: false);
    final systemController = Provider.of<SystemController>(context, listen: false);

    if (form.valid) {
      try {
        //get input
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final name = nameController.text.trim();
        print(email);

        //await firebase signup
        final result = await authProvider.signUp(context, email, password, name);
        print(result.user?.email);
        if (result.user != null && mounted) {
          await authProvider.sendEmailVerification(context).then((value) => {
                context.router.push(
                  EmailSentRoute2(email: email, isLoggedIn: true),
                )
              });
        }

        //clear message in case of return
        authProvider.clearErrorMessage();
      } on FirebaseAuthException catch (err) {
        systemController.handleFirebaseEx(err.code);
      } finally {
        form.controls.forEach((key, value) {
          value.updateValue('');
          value.markAsUntouched();
        });
      }
    } else {
      print('form is shit');

      print(form.errors);
      form.errors.forEach((key, value) {
        print('$key $value');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          BigField(
            hintText: 'nameGuide'.tr(),
            obscureText: false, //obscureText
            textInputType: TextInputType.text,
            label: 'fullName'.tr(),
            formName: 'name',
            controller: nameController,
            validationMessages: InputValidation.nameMap,
          ),
          const SizedBox(height: 18.0), // Spacing
          // Email Field
          BigField.email(
            formName: 'email',
            controller: emailController,
            label: 'email'.tr(),
          ),
          // Password Field
          const SizedBox(height: 18.0), // Spacing
          BigField.password(
            hintText: 'passGuide'.tr(),
            formName: 'password',
            controller: passwordController,
            label: 'pass'.tr(),
          ), // Sign-Up Button
          const SizedBox(height: 33.0), // Spacing

          Center(
            child: FormSubmitButton(
              text: 'signUp'.tr().toUpperCase(),
              onPressed: _handleSignUp,
            ),
          ),
        ],
      ),
    );
  }
}