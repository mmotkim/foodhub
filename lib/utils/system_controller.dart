import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/gen/locale_keys.g.dart';

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
}
