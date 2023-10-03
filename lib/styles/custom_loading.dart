import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/styles/custom_texts.dart';

class CustomLoading {
  void loadingLight() {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.clear
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..backgroundColor = CustomColors.fieldBorder.withOpacity(0.65)
      ..indicatorColor = Colors.black.withOpacity(0.75)
      ..textColor = Colors.black
      ..indicatorSize = 50
      ..radius = 10
      ..boxShadow = []
      ..textStyle = CustomTextStyle.fieldText
      ..userInteractions = true;
  }
}
