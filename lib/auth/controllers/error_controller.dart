import 'package:flutter/material.dart';

class ErrorController extends ChangeNotifier {
  String? errorMessage;
  void setErrorMessage(String message) {
    if (message != errorMessage) {
      errorMessage = message;
    }
    notifyListeners();
  }

  void clearErrorMessage() {
    errorMessage = null; // Clear the error message
    notifyListeners();
  }
}
