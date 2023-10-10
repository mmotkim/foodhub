import 'package:flutter/widgets.dart';
import 'package:foodhub/api/http.dart';

class MailApi {
  static Future<void> apiSendCode(String email) async {
    final response = await dio.post(
      '/mail/send-verification-code',
      data: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      debugPrint('api sent!');
    } else {
      throw Exception(
          'Failed to send code: ${response.statusCode} ${response.data}');
    }
  }

  static Future<void> apiVerifyCode(String code) async {
    final response = await dio.post(
      '/mail/verify-code',
      data: {
        'code': code,
      },
    );

    if (response.statusCode == 200) {
      debugPrint('code good');
    } else {
      throw Exception(
          'Failed to verify code: ${response.statusCode} ${response.data}');
    }
  }
}
