import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class RetypePasswordScreen extends StatefulWidget {
  const RetypePasswordScreen({super.key});

  @override
  State<RetypePasswordScreen> createState() => _RetypePasswordScreenState();
}

class _RetypePasswordScreenState extends State<RetypePasswordScreen> {
  final form = FormGroup({
    'password': InputValidation.passwordLogin,
  });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthController>().clearErrorMessage();
    });
  }

  @override
  void dispose() {
    form.controls.forEach((key, value) {
      value.updateValue('');
      value.markAsUntouched();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final password = TextEditingController();

    handleOnPressed(BuildContext context) async {
      final systemController = context.read<SystemController>();
      final authController = context.read<AuthController>();

      final password = form.control('password').value;

      try {
        if (form.invalid) return;
        systemController.showLoading();

        await authController.retypePassword(context, password).then(
              (value) => {
                context.router.replace(const NewPasswordRoute()),
                systemController.dismiss(),
              },
            );
      } on FirebaseAuthException catch (e) {
        print('retype password: $e');
      } catch (_) {
        systemController.dismiss();
        rethrow;
      }
    }

    ReactiveForm retypePasswordForm(
        FormGroup form, TextEditingController password, BuildContext context) {
      return ReactiveForm(
        formGroup: form,
        child: Column(
          children: [
            BigField.password(
              formName: 'password',
              controller: password,
              hintText: LocaleKeys.changePasswordHint.tr(),
              label: null,
              padding: 0.0,
            ),
            errorMessage(context),
            const SizedBox(height: 25),
            FormSubmitButton(
                text: LocaleKeys.next.tr().toUpperCase(),
                onPressed: () => handleOnPressed(context),
                textStyle: CustomTextStyle.altLabel),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              _topDeco(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 180),
                    _title(context),
                    const SizedBox(height: 14),
                    _body(context),
                    retypePasswordForm(form, password, context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Center errorMessage(BuildContext context) {
    return Center(
      child: Text(context.watch<AuthController>().errorMessage ?? '',
          style: CustomTextStyle.errorText(context)),
    );
  }

  SizedBox _body(BuildContext context) {
    return SizedBox(
      width: 236,
      child: Text(
        LocaleKeys.changePasswordBody.tr(),
        style: CustomTextStyle.bodySmall(context),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      LocaleKeys.changePassword.tr(),
      style: CustomTextStyle.headlineLarge(context),
    );
  }

  Container _topDeco() {
    return Container(
      height: 80, // Adjust the height as needed
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.topDeco.provider(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
