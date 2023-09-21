// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;

  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void clearErrorMessage() {
    errorMessage = null; // Clear the error message
    notifyListeners();
  }

  // Sign up with email and password
  Future<UserCredential> signUp(
      String email, String password, String fullName) async {
    try {
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = newUser.user;
      await user?.updateDisplayName(fullName);
      await user?.reload();

      return newUser;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      print(e.code == 'email-already-in-use');
      if (e.code == 'email-already-in-use') {
        setErrorMessage(e.message!);
      } else if (e.code == 'weak-password') {
        setErrorMessage(e.message!);
      }
      rethrow;
    }
  }

  // Sign in with email and password
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
