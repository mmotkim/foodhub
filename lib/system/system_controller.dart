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
    final logger = Logger();

    logger.e('My man.. Code $statusCode, Uri $uri, and Data $data');

    if (statusCode == 500 && uri.contains('verify-code')) {
      showError(LocaleKeys.errorWrongOTP.tr());
      return LocaleKeys.errorWrongOTP.tr();
    } else if (data.contains('Account information is incorrect')) {
      showError(LocaleKeys.errorWrongCredentials.tr());
      return LocaleKeys.errorWrongCredentials.tr();
    } else if (data.contains('must be a valid email')) {
      showError(LocaleKeys.emailWrongFormat.tr());
      return LocaleKeys.emailWrongFormat.tr();
    } else if (data.contains('Email was registered!')) {
      showError(LocaleKeys.errorEmailInUse.tr());
      return LocaleKeys.errorEmailInUse.tr();
    } else if (statusCode == 401) {
      showError('Unauthorized');
      return 'Unauthorized';
    } else if (statusCode == 403 && uri.contains('refresh-token')) {
      showError('Your session expired, please login again');
      return 'Sesssion Expired';
    } else {
      showError("Something isn't right.. Try again later");
      return "Something isn't right.. Try again later";
    }
  }

  void handleArgumentError(ArgumentError e) {
    debugPrint(e.name);
    debugPrint(e.message);

    if (e.name != null) {
      showError(e.name!);
    }
  }
}
