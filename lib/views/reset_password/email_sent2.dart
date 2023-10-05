import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/components/bottom_help_text.dart';
import 'package:foodhub/components/secondary_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/styles/custom_texts.dart';

class EmailSentScreen2 extends StatefulWidget {
  const EmailSentScreen2({super.key, required this.emailSent});
  final String emailSent;

  @override
  State<EmailSentScreen2> createState() => _EmailSentScreen2State();
}

class _EmailSentScreen2State extends State<EmailSentScreen2>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState for resumed state
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      Navigator.of(context).popUntil((route) {
        return route.isFirst || route.settings.name == '/login';
      });
    }
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
                text: LocaleKeys.resetPasswordCompleteAction,
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
        LocaleKeys.resetPasswordComplete.tr(args: [
          widget.emailSent,
        ]),
        style: CustomTextStyle.bodySmall(context),
        textAlign: TextAlign.center,
      ),
    );
  }

  Center _bottomHelpText() {
    return Center(
      child: BottomHelpText.light(
        text: '${LocaleKeys.authVerificationBottom.tr()} ',
        actionText: LocaleKeys.authVerificationBottomAction.tr(),
        onPressed: () {},
        fontSize: 16.0,
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
    Navigator.of(context).popUntil((route) {
      return route.isFirst || route.settings.name == '/login';
    });
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
