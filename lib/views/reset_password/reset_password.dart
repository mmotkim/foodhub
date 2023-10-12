// ignore_for_file: unused_element, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/form_utils.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final email = TextEditingController();
  final form = FormGroup({
    'email': InputValidation.email,
  });

  @override
  void dispose() {
    FormUtils.disposeAll(form);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    onPressed(BuildContext context) async {
      String emailValue = form.control('email').value.trim();

      // if (form.valid) {
      //   EmailVerificationController().requestResetPassword(context, email);
      // }

      final authProvider = Provider.of<AuthController>(context, listen: false);
      await authProvider.sendPasswordResetEmail(context, emailValue).then(
          (value) => context.router
              .push(EmailSentRoute2(email: emailValue, isLoggedIn: false)));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => EmailSentScreen2(emailSent: email)));

      //dispose value
      email.clear();
    }

    onPressedLoggedIn(BuildContext context) async {
      // String email = form.control('email').value.trim();

      if (form.valid) {
        // EmailVerificationController().requestResetPassword(context, email);
        //own backend^
        context.router.push(const RetypePasswordRoute());
      }
    }

    ReactiveForm formContent(BuildContext context) {
      return ReactiveForm(
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
              text: LocaleKeys.resetPasswordAction.tr().toUpperCase(),
              onPressed: () => widget.isLoggedIn
                  ? onPressedLoggedIn(context)
                  : onPressed(context),
              textStyle: CustomTextStyle.altLabel,
            )
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
                      _title(context),
                      const SizedBox(height: 12),
                      _body(context),
                      formContent(context),
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

  SizedBox _body(BuildContext context) {
    return SizedBox(
      width: 236,
      child: Text(
        '${LocaleKeys.resetPasswordBody.tr()} ',
        style: CustomTextStyle.bodySmall(context),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      LocaleKeys.resetPassword.tr(),
      style: CustomTextStyle.headlineLarge(context),
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
