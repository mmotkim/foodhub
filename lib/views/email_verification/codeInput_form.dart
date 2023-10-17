import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/auth/controllers/email_verification_controller.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_pin_code_fields/reactive_pin_code_fields.dart';

class CodeInputForm extends StatefulWidget {
  const CodeInputForm({
    super.key,
    required this.email,
    required this.isLoggedIn,
  });
  final String email;
  final bool isLoggedIn;

  @override
  State<CodeInputForm> createState() => _CodeInputFormState();
}

class _CodeInputFormState extends State<CodeInputForm> with WidgetsBindingObserver {
  int _secondsRemaining = 60;

  Timer? _resendTimer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _startResendTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resendTimer?.cancel();

    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    _secondsRemaining = 5;

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void resend(BuildContext context) async {
    _startResendTimer();
    await EmailVerificationController().requestEmailConfirmation(context, widget.email);
  }

  @override
  Widget build(BuildContext context) {
    final form = FormGroup({
      'pin': FormControl<int>(),
    });

    return Column(
      children: [
        errorMessage(context),
        const SizedBox(height: 15),
        ReactiveForm(
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
              fieldHeight: 65,
              fieldWidth: 45,
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
        ),
        const SizedBox(height: 32),
        bottomHelpText(context),
      ],
    );
  }

  Center errorMessage(BuildContext context) {
    return Center(
      child: Text(
        context.watch<ApplicationState>().errorMessage ?? '',
        style: CustomTextStyle.errorText(context),
      ),
    );
  }

  Center bottomHelpText(BuildContext context) {
    return Center(
      child: BottomHelpText.light(
        text: '${LocaleKeys.authVerificationBottom.tr()} ',
        actionText: LocaleKeys.authVerificationBottomAction.tr(),
        onPressed: () async {
          EmailVerificationController().requestEmailConfirmation(context, widget.email);
        },
        fontSize: 16.0,
      ),
    );
  }

  _handleSubmit(String code) async {
    final sysProvider = context.read<SystemController>();

    try {
      //   await EmailVerificationController().verifyCode(context, code).then((value) {
      //     final appState = context.read<ApplicationState>();
      //     EasyLoading.showSuccess('fuck yeah');
      //     if (appState.errorMessage == null) {
      //       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //         context.router.push(const HomeRoute());
      //       });
      //     }
      //   }).catchError((error) {
      //     if (context.read<ApplicationState>().errorMessage == null) {
      //       throw Exception(error);
      //     }
      //   });
      //   print(code);
      // } catch (err) {
      //   EasyLoading.showError(LocaleKeys.errorWrongOTP.tr());
      //   print('fuck. $err');
      //   rethrow;
      // } finally {
      //   Future.delayed(const Duration(milliseconds: 1500), () {
      //     context.read<ApplicationState>().clearErrorMessage();
      //   });
      // }
      sysProvider.showLoading();
      await EmailVerificationController().verifyCode(context, code);
      if (mounted) {
        EasyLoading.showSuccess('verified');
        context.router.push(const HomeRoute());
      }
    } on DioException catch (e) {
      sysProvider.handleDioException(e);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<ApplicationState>().setErrorMessage('Incorrect code. Please try again');
      });
    } finally {
      sysProvider.dismiss();
    }
  }
}
