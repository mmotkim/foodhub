import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:logger/logger.dart';

class SystemController extends ChangeNotifier {
  void showError(String message) {
    EasyLoading.showError(message);
  }

  void showInfo(String message) {
    EasyLoading.showInfo(message);
  }

  void dismiss() => EasyLoading.dismiss();
  void showLoading() {
    EasyLoading.show();
  }

  void showSuccess(String message) {
    EasyLoading.showSuccess(message);
  }

  void handleFirebaseEx(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        showError(LocaleKeys.errorEmailInUse.tr());
      case 'too-many-requests':
        showError('Too many requests!');
      case 'invalid-login-credentials':
        showError(LocaleKeys.errorWrongCredentials.tr());
      case 'invalid-verification-code':
        showError(LocaleKeys.errorWrongOTP.tr());
      default:
        showError('An error has occured');
    }
  }

  String handleDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final uri = error.requestOptions.path;
    final data = jsonEncode(error.response?.data);
    final _logger = Logger();

    _logger.e('My man.. Code $statusCode, Uri $uri, and Data $data');

    if (statusCode == 500 && uri.contains('verify-code')) {
      showError('Incorrect code');
      return 'Incorrect code';
    } else if (data.contains('Account information is incorrect')) {
      showError('Incorrect login details');
      return 'Incorrect login details';
    } else if (data.contains('must be a valid email')) {
      showError('Invalid email address');
      return 'Invalid email address';
    } else if (data.contains('Email was registered!')) {
      showError('Email already registered');
      return 'Email already registered';
    } else {
      showError('unhandled.. fuck.');
      return 'unhandled.. fuck.';
    }
  }

  void handleArgumentError(ArgumentError e) {
    print(e.name);
    print(e.message);

    if (e.name != null) {
      showError(e.name!);
    }
  }
}
