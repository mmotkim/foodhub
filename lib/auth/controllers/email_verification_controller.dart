import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/styles/animated_routes.dart';
import 'package:foodhub/views/reset_password/email_sent.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../views/reset_password/new_password.dart';

class EmailVerificationController {
  // late Timer _timer;

  void requestResetPassword(BuildContext context, String email) async {
    final authController = Provider.of<AuthController>(context, listen: false);

    try {
      Navigator.push(
          context, AnimatedRoutes.slideRight(const EmailSentScreen()));

      String code = authController.generateRandomCode(6);

      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': 'service_egv33mc',
          'template_id': 'template_nsp7q0e',
          'user_id': 'iPRCn4XM0G4pUFlph',
          'accessToken': 'X-fjH37Pfwn1kTjY_rl_u',
          'template_params': {
            'code': code,
          },
        }),
      );

      // setTimerForAutoRedirect((Timer timer) {
      //   authController.getCurrentUser()?.reload();
      //   final user = authController.getCurrentUser();

      //   if (user?.emailVerified ?? false) {
      //     timer.cancel();
      //     Navigator.push(
      //         context, AnimatedRoutes.slideRight(const NewPasswordScreen()));
      //   }
      // });
    } catch (ex) {
      print('fuck! $ex');
    }
  }

  bool verifyCode(BuildContext context, String userInput) {
    String? _code = Provider.of<AuthController>(context, listen: false).code;
    if (_code != null) {
      return userInput == _code ? true : false;
    } else {
      return false;
    }
  }

  // void setTimerForAutoRedirect(Function function) {
  //   _timer =
  //       Timer.periodic(const Duration(seconds: 3), (timer) => function(timer));
  // }
}
