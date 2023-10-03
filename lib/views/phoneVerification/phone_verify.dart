import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/styles/animated_routes.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/views/loading_screen/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_pin_code_fields/reactive_pin_code_fields.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    children: _verificationContent(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _verificationContent(BuildContext context) {
    return <Widget>[
      //heading
      Text(
        LocaleKeys.verificationCode.tr(),
        style: CustomTextStyle.headlineLarge(context),
      ),
      const SizedBox(height: 12),
      //body
      Text(
        '${LocaleKeys.authVerificationBody.tr()} ',
        style: CustomTextStyle.bodySmall(context),
      ),
      const SizedBox(height: 16),
      errorMessage(context),
      const SizedBox(height: 15),
      const CodeForm(),
      const SizedBox(height: 32),
      bottomHelpText(),
      const SizedBox(height: 300),
    ];
  }

  Center bottomHelpText() {
    return Center(
      child: BottomHelpText.light(
        text: '${LocaleKeys.authVerificationBottom.tr()} ',
        actionText: LocaleKeys.authVerificationBottomAction.tr(),
        onPressed: () {},
        fontSize: 16.0,
      ),
    );
  }

  Center errorMessage(BuildContext context) {
    return Center(
      child: Text(
        context.watch<AuthController>().errorMessage ?? '',
        style: CustomTextStyle.errorText(context),
      ),
    );
  }
}

class CodeForm extends StatefulWidget {
  const CodeForm({
    super.key,
  });

  @override
  State<CodeForm> createState() => _CodeFormState();
}

class _CodeFormState extends State<CodeForm> {
  @override
  Widget build(BuildContext context) {
    final form = FormGroup({
      'pin': FormControl<int>(),
    });

    return ReactiveForm(
      formGroup: form,
      child: ReactivePinCodeTextField<int>(
        length: 6,
        formControlName: 'pin',
        keyboardType: TextInputType.number,
        textStyle: CustomTextStyle.pinCode,
        cursorWidth: 1.50,
        cursorHeight: 22,
        cursorColor: CustomColors.cursor,
        enableActiveFill: true,
        pinTheme: PinTheme(
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedFillColor: Colors.white,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(12),
          fieldHeight: 50,
          fieldWidth: 50,
          borderWidth: 1,
          activeColor: CustomColors.fieldBorder,
          selectedColor: CustomColors.primary,
          inactiveColor: CustomColors.fieldBorder,
        ),
        boxShadows: [CustomColors.pinFieldShadow],
        animationType: AnimationType.scale,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onCompleted: (code) => _handleSubmit(code),
        onSubmitted: (code) => _handleSubmit(code),
      ),
    );
  }

  _handleSubmit(String code) async {
    final authProvider = Provider.of<AuthController>(context, listen: false);

    try {
      Navigator.of(context).push(AnimatedRoutes.slideRight(LoadingScreen(
        loadingMessage: LocaleKeys.authLoadingMessageSignUp.tr(),
        loadedMessage: LocaleKeys.signUpComplete.tr(),
      )));

      await authProvider.verifyOTP(code);
    } catch (err) {
      rethrow;
    } finally {}
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

class CodeInput extends StatelessWidget {
  const CodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3FE8E8E8),
            blurRadius: 45,
            offset: Offset(15, 20),
            spreadRadius: 0,
          )
        ],
      ),
      child: ReactiveTextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: "0"),
        style: CustomTextStyle.pinCode,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
