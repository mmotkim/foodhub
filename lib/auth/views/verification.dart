import 'package:flutter/material.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_pin_code_fields/reactive_pin_code_fields.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final form = FormGroup({
      'pin': FormControl<int>(),
    });

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const TopDeco(),
              SizedBox(
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //top decoration
                      const SizedBox(height: 8.0),
                      // Sign Up Heading Title
                      Text(
                        'Verification Code',
                        style: CustomTextStyle.headlineLarge(context),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Please type the verification code sent to asdfasdfasdf ',
                        style: CustomTextStyle.bodySmall(context),
                      ),
                      const SizedBox(height: 31),
                      const SizedBox(height: 32),
                      ReactiveForm(
                        formGroup: form,
                        child: ReactivePinCodeTextField<int>(
                          length: 4,
                          formControlName: 'pin',
                        ),
                      ),
                      const SizedBox(height: 400),
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
}

class TopDeco extends StatelessWidget {
  const TopDeco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
