// ignore_for_file: unused_element, avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final email = TextEditingController();
    final form = FormGroup({
      'email': InputValidation.email,
    });

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
                      Container(
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
                              onPressed: () {},
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
