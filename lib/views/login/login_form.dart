import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/api_auth_controller.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/controllers/email_verification_controller.dart';
import 'package:foodhub/components/big_field.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/components/horizontal_separator.dart';
import 'package:foodhub/components/social_button.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:foodhub/utils/form_utils.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthController>().clearErrorMessage();
      context.read<ApplicationState>().clearErrorMessage();
    });
  }

  @override
  void dispose() {
    FormUtils.disposeAll(form);
    super.dispose();
  }

  final form = FormGroup({
    'email': InputValidation.email,
    'password': InputValidation.passwordLogin,
  });

  void _handleLogin() async {
    if (form.valid) {
      //get input
      final email = form.control('email').value;
      final password = form.control('password').value;

      context.read<ApplicationState>().useFirebaseAuth
          ? await _firebaseLogin(email, password)
          : await _apiLogin(email, password);
    }
  }

  Future<void> _apiLogin(String email, String password) async {
    final systemController = Provider.of<SystemController>(context, listen: false);
    final appState = context.read<ApplicationState>();
    ApiAuthController apiController = context.read<ApiAuthController>();
    try {
      systemController.showLoading();
      await apiController.signIn(context, email, password).then((value) async {
        await apiController.getProfile().then((value) async {
          if (value.isVerifiedEmail) {
            context.router.push(const HomeRoute());
          } else {
            await EmailVerificationController().requestEmailConfirmation(context, email);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.router.push(VerifyCodeRoute(email: email, isLoggedIn: true));
            });
          }
        });
        systemController.showSuccess(LocaleKeys.done);
      });
    } on DioException catch (e) {
      appState.setErrorMessage(systemController.handleDioException(e));
    } on ArgumentError catch (e) {
      systemController.handleArgumentError(e);
    } finally {
      systemController.dismiss();
    }
  }

  Future<void> _firebaseLogin(String email, String password) async {
    final authProvider = Provider.of<AuthController>(context, listen: false);
    final systemController = Provider.of<SystemController>(context, listen: false);
    try {
      //await firebase signup
      final result = await authProvider.signIn(context, email, password);
      if (result.user != null && mounted) {
        //check if meail verified
        if (result.user!.emailVerified) {
          context.router.replaceAll([const HomeRoute()]);
        } else {
          context.router.push(EmailSentFirebaseRoute(email: email, isLoggedIn: true));
        }
      }
    } on FirebaseAuthException catch (e) {
      systemController.handleFirebaseEx(e.code);
    } finally {
      Future.delayed(const Duration(milliseconds: 1500), () => systemController.dismiss());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          errorMessage(context),
          const SizedBox(height: 14.0),
          BigField.email(
            formName: 'email',
            label: LocaleKeys.email.tr(),
          ),
          const SizedBox(height: 28.0),
          BigField.password(
            hintText: LocaleKeys.passGuide.tr(),
            formName: 'password',
            label: LocaleKeys.pass.tr(),
          ),
          const SizedBox(height: 28),
          BottomHelpText.light(
              text: '',
              actionText: '${LocaleKeys.forgotPassword.tr()}?',
              onPressed: () {
                context.router.push(ResetPasswordRoute(isLoggedIn: false));
              }),
          const SizedBox(height: 25),
          FormSubmitButton(
            text: LocaleKeys.login.tr().toUpperCase(),
            onPressed: _handleLogin,
          ),
          const SizedBox(height: 50),
          HorizontalSeparator.dark(text: LocaleKeys.signInWith.tr()),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                SocialButton.facebook(
                  onPressed: () {},
                ),
                const SizedBox(width: 40),
                SocialButton.google(
                  onPressed: _onGoogle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget errorMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Center(
        child: Text(
            context.read<ApplicationState>().useFirebaseAuth
                ? context.watch<AuthController>().errorMessage ?? ''
                : context.watch<ApplicationState>().errorMessage ?? '',
            style: CustomTextStyle.errorText(context)),
      ),
    );
  }

  Future<void> _onGoogle() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    authController.signInWithGoogle(context).then((value) => {
          if (authController.getCurrentUser() != null) {context.router.push(const HomeRoute())}
        });
  }
}
