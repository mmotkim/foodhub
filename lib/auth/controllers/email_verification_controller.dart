import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/api/custom_interceptor.dart';
import 'package:foodhub/api/rest_client.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class EmailVerificationController {
  // late Timer _timer;
  final _logger = Logger();
  final _dio = Dio()..interceptors.add(CustomInterceptor());

  Future<void> requestResetPassword(BuildContext context, String email) async {
    final systemController = Provider.of<SystemController>(context, listen: false);
    final client = RestClient(_dio);

    try {
      systemController.showLoading();
      final body = {"email": email};

      await client.apiSendVerificationCode(body).then((value) {
        systemController.showSuccess('Code sent.');
      });
    } catch (ex) {
      print('fuck! $ex');
    } finally {
      systemController.dismiss();
    }
  }

  Future<void> requestEmailConfirmation(BuildContext context, String email) async {
    final systemController = Provider.of<SystemController>(context, listen: false);
    final client = RestClient(_dio);

    try {
      systemController.showLoading();
      final body = {"email": email};

      await client.apiSendVerificationCode(body).then((value) {
        systemController.showSuccess('Code sent.');
      }).catchError((obj) {
        if (obj.runtimeType == DioException) {
          final res = (obj as DioException).response;
          _logger.e('Verify Code Api call error: ${res?.statusCode}');
          if (res?.statusCode == 400) {
            context.read<ApplicationState>().setErrorMessage(LocaleKeys.authVerificationError.tr());
          }
        }
      });
    } catch (ex) {
      print('fuck! $ex');
    } finally {
      systemController.dismiss();
    }
  }

  // bool verifyCode(BuildContext context, String userInput) {
  //   String? code = Provider.of<AuthController>(context, listen: false).code;
  //   if (code != null) {
  //     return userInput == code;
  //   } else {
  //     print('no code found');
  //     return false;
  //   }
  // }

  Future<void> verifyCode(BuildContext context, String userInput) async {
    final client = RestClient(_dio);
    try {
      final code = {"code": userInput};
      print(code);
      await client.apiVerifyCode(code).then((value) {
        _logger.i('Verification complete');
      });
    } catch (e) {
      if (e.runtimeType == DioException) {
        final res = (e as DioException).response;
        _logger.e('Verify Code Api call error: ${res?.statusCode}');
        if (res?.statusCode == 500) {
          rethrow;
        }
      }
      _logger.e('Error at apiVerifyCode call');
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
