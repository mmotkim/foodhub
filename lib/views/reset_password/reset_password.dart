// ignore_for_file: unused_element, avoid_print

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/controllers/email_verification_controller.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/styles/animated_routes.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:foodhub/views/reset_password/email_sent.dart';
import 'package:foodhub/views/reset_password/email_sent2.dart';
import 'package:foodhub/views/signup/signup.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final email = TextEditingController();
    final form = FormGroup({
      'email': InputValidation.email,
    });

    onPressed(BuildContext context) async {
      String emailValue = form.control('email').value.trim();

      // if (form.valid) {
      //   EmailVerificationController().requestResetPassword(context, email);
      // }

      final authProvider = Provider.of<AuthController>(context, listen: false);
      await authProvider.sendPasswordResetEmail(context, emailValue).then(
          (value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EmailSentScreen2(emailSent: emailValue))));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => EmailSentScreen2(emailSent: email)));

      //dispose value
      email.clear();
    }

    onPressedLoggedIn(BuildContext context) async {
      String email = form.control('email').value.trim();

      if (form.valid) {
        EmailVerificationController().requestResetPassword(context, email);
      }
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
              topDeco(),
              SizedBox(
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //top decoration
                      const SizedBox(height: 180.0),
                      // Sign Up Heading Title
                      Text(
                        LocaleKeys.resetPassword.tr(),
                        style: CustomTextStyle.headlineLarge(context),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 236,
                        child: Text(
                          '${LocaleKeys.resetPasswordBody.tr()} ',
                          style: CustomTextStyle.bodySmall(context),
                        ),
                      ),
                      ReactiveForm(
                        formGroup: form,
                        child: Column(
                          children: [
                            BigField.email(
                              controller: email,
                              formName: 'email',
                              padding: 0.0,
                            ),
                            const SizedBox(height: 35),
                            FormSubmitButton(
                              text: LocaleKeys.resetPasswordAction
                                  .tr()
                                  .toUpperCase(),
                              onPressed: () => isLoggedIn
                                  ? onPressedLoggedIn(context)
                                  : onPressed(context),
                              textStyle: CustomTextStyle.altLabel,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container topDeco() {
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
