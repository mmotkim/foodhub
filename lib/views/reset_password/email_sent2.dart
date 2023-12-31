import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/secondary_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:provider/provider.dart';

@RoutePage()
class EmailSentScreen2 extends StatefulWidget {
  const EmailSentScreen2(
      {super.key, required this.email, required this.isLoggedIn});
  final String email;
  final bool isLoggedIn;

  @override
  State<EmailSentScreen2> createState() => _EmailSentScreen2State();
}

class _EmailSentScreen2State extends State<EmailSentScreen2>
    with WidgetsBindingObserver {
  int _secondsRemaining = 60;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _secondsRemaining = 0;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      print('fuckss');
      // Navigator.of(context).popUntil((route) {
      //   return route.isFirst || route.settings.name == '/login';
      // });
      context.router.popUntilRouteWithName(LoginRoute.name);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 5;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {
          // Enable the resend button
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void resend(BuildContext context) async {
    _startTimer();
    final authProvider = Provider.of<AuthController>(context, listen: false);
    widget.isLoggedIn
        ? await authProvider.sendEmailVerification(context)
        : await authProvider.sendPasswordResetEmail(context, widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Stack(
              children: [TopDeco()],
            ),
            const SizedBox(height: 80),
            _icon(),
            const SizedBox(height: 30),
            _heading(context),
            const SizedBox(height: 20),
            _bodyText(context),
            const SizedBox(height: 15),
            _bottomHelpText(),
            const SizedBox(height: 38),
            SecondaryButton(
                text: LocaleKeys.resetPasswordCompleteAction.tr(),
                onPressed: onPressed,
                width: 248),
          ],
        ),
      ),
    );
  }

  Text _heading(BuildContext context) {
    return Text(
      'Check your mail',
      style: CustomTextStyle.headlineLarge(
        context,
        color: CustomColors.primary,
      ),
    );
  }

  SizedBox _bodyText(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Text(
        widget.isLoggedIn
            ? LocaleKeys.emailSentBody.tr(args: [widget.email])
            : LocaleKeys.resetPasswordComplete.tr(args: [widget.email]),
        style: CustomTextStyle.bodySmall(context),
        textAlign: TextAlign.center,
      ),
    );
  }

  Center _bottomHelpText() {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: ValueNotifier(_secondsRemaining),
        builder: (context, value, child) => BottomHelpText.light(
          text: '${LocaleKeys.authVerificationBottom.tr()} ',
          actionText: value == 0
              ? LocaleKeys.authVerificationBottomAction.tr()
              : '${LocaleKeys.resend.tr()} in $value seconds',
          onPressed: () {
            value > 0 ? null : resend(context);
          },
          fontSize: 16.0,
          actionColor: value == 0 ? CustomColors.primary : CustomColors.label,
        ),

        // child: BottomHelpText.light(
        //   text: '${LocaleKeys.authVerificationBottom.tr()} ',
        //   actionText: LocaleKeys.authVerificationBottomAction.tr(),
        //   onPressed: () {},
        //   fontSize: 16.0,
        // ),
      ),
    );
  }

  Center _icon() {
    return const Center(
      child: Icon(
        Icons.mark_email_unread,
        size: 100,
        color: CustomColors.primary,
      ),
    );
  }

  void onPressed() {
    // Navigator.of(context).popUntil((route) {
    //   return route.isFirst || route.settings.name == '/login';
    // });

    context.router.popUntilRouteWithName(LoginRoute.name);
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
