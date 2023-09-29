// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/styles/animated_routes.dart';
import 'package:foodhub/views/loading_screen/loading_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  // void handleGoogleSignIn(BuildContext context) async {
  //   Navigator.of(context).push(AnimatedRoutes.slideRight(LoadingScreen(
  //     loadingMessage: LocaleKeys.authLoadingMessageSignUp.tr(),
  //     loadedMessage: LocaleKeys.signInComplete.tr(),
  //   )));

  //   final result = await signInWithGoogle();
  //   print(result.user?.email);
  // }

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
      if (e.code == 'email-already-in-use') {
        setErrorMessage(LocaleKeys.errorEmailInUse.tr());
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
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        setErrorMessage(LocaleKeys.errorWrongCredentials.tr());
      } else {
        setErrorMessage(e.message!);
      }
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

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    Navigator.of(context).push(AnimatedRoutes.slideRight(LoadingScreen(
      loadingMessage: LocaleKeys.authLoadingMessageSignUp.tr(),
      loadedMessage: LocaleKeys.signInComplete.tr(),
    )));
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      setErrorMessage(e.message!);
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
