import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/database/entity/verification_code.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EmailVerificationController {
  // late Timer _timer;

  Future<void> requestResetPassword(BuildContext context, String email) async {
    final authController = Provider.of<AuthController>(context, listen: false);
    final systemController =
        Provider.of<SystemController>(context, listen: false);

    try {
      systemController.showLoading();
      context.router.push(const EmailSentRoute());

      //checks if email belongs to account

      VerificationCode code = authController.generateVerificationCode(4);
      await mailApi(code);

      // await authDAO.addVerificationCode(code, email);

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
    } finally {
      systemController.dismiss();
    }
  }

  Future<void> mailApi(VerificationCode verificationCode) async {
    final baseUrl = dotenv.env['BASE_URL'];
    final path = dotenv.env['sendApi'];

    final url = Uri.parse("$baseUrl$path");

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
          'code': verificationCode.code,
        },
      }),
    );
    print(verificationCode.code);
  }

  bool verifyCode(BuildContext context, String userInput) {
    String? _code = Provider.of<AuthController>(context, listen: false).code;
    if (_code != null) {
      return userInput == _code ? true : false;
    } else {
      print('no code found');
      return false;
    }
  }

  void requestFirebaseResetPassword(BuildContext context, String email) {
    // final authController = Provider.of<AuthController>(context, listen: false);
  }
  // void setTimerForAutoRedirect(Function function) {
  //   _timer =
  //       Timer.periodic(const Duration(seconds: 3), (timer) => function(timer));
  // }
}
