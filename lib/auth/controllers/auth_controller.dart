// ignore_for_file: avoid_print

import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/database/entity/verification_code.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/utils/system_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;
  var verificationId = '';
  String? code;

  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void clearErrorMessage() {
    print("clearedErrorMessage");
    errorMessage = null; // Clear the error message
    notifyListeners();
  }

  void setCode(String codeString) {
    code = codeString;
    notifyListeners();
  }

  // Get the current user - only after sure user is signed in
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<String?> getProviderName() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        for (UserInfo userInfo in user.providerData) {
          print(userInfo.providerId);
          // Check each provider's type
          if (userInfo.providerId == 'google.com') {
            return 'Google'; // User is signed in with Google
          } else if (userInfo.providerId == 'facebook.com') {
            return 'Facebook'; // User is signed in with Facebook
          } else if (userInfo.providerId == 'password') {
            return 'Email/Password'; // User is signed in with email/password
          } else if (userInfo.providerId == 'phone') {
            return 'Phone';
          }
          // Add more conditions for other providers as needed
        }
      }
      return null; // User is not authenticated with any known provider
    } catch (e) {
      print('Error getting provider name: $e');
      return null; // Handle errors gracefully
    }
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
  Future<UserCredential> signUp(BuildContext context, String email,
      String password, String fullName) async {
    final systemController =
        Provider.of<SystemController>(context, listen: false);
    try {
      systemController.showLoading();

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
    } finally {
      Future.delayed(
          const Duration(milliseconds: 1500), () => systemController.dismiss());
    }
  }

  // Sign in with email and password
  Future<UserCredential> signIn(
      BuildContext context, String email, String password) async {
    final systemController =
        Provider.of<SystemController>(context, listen: false);
    try {
      systemController.showLoading();
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        setErrorMessage(LocaleKeys.errorWrongCredentials.tr());
        rethrow;
      } else {
        setErrorMessage(e.message!);
      }
      rethrow;
    } finally {}
  }

  // Sign out
  Future<void> signOut() async {
    if (await getProviderName() == 'Google') {
      await GoogleSignIn().disconnect();
    }
    await _auth.signOut();
    notifyListeners();
  }

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    final systemController =
        Provider.of<SystemController>(context, listen: false);
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
      systemController.showError(e.message!);
      rethrow;
    } catch (_) {
      rethrow;
    } finally {
      systemController.dismiss();
    }
  }

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        _auth.signInWithCredential(credential);
        print(_auth.currentUser?.phoneNumber);
        print('${_auth.currentUser} wow');
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          setErrorMessage('The provided phone number is invalid!');
        } else {
          setErrorMessage('Something went wrong, please try again later.');
          print(e.code);
          print(e.message);
        }
      },
    );
  }

  Future<void> verifyOTP(String otp) async {
    final auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      print(userCredential.user?.phoneNumber);
      print(userCredential.user);

      // return userCredential.user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-verification-code') {
        setErrorMessage(LocaleKeys.errorWrongOTP.tr());
        print(errorMessage);
      } else {
        rethrow;
      }
      // return true;
    } catch (_) {
      rethrow;
    } finally {}
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    final systemController =
        Provider.of<SystemController>(context, listen: false);

    try {
      systemController.showLoading();

      _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      systemController.handleFirebaseEx(e.code);
    } finally {
      systemController.dismiss();
    }
  }

  Future<void> sendPasswordResetEmail(
      BuildContext context, String email) async {
    final systemController =
        Provider.of<SystemController>(context, listen: false);

    //set locale
    await FirebaseAuth.instance
        .setLanguageCode(context.locale.languageCode.toString());

    try {
      systemController.showLoading();

      await _auth.sendPasswordResetEmail(email: email);

      systemController.showInfo('Email sent');
    } on FirebaseAuthException catch (e) {
      systemController.handleFirebaseEx(e.code);
    } finally {
      systemController.dismiss();
    }
  }

  VerificationCode generateVerificationCode(int len) {
    var r = Random();
    const chars = '0123456789';
    final now = DateTime.now();
    String code =
        List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
    setCode(code);

    return VerificationCode(code: code, created: now);
  }

  // Sign in with email and password
  Future<UserCredential> retypePassword(
      BuildContext context, String password) async {
    final systemController =
        Provider.of<SystemController>(context, listen: false);

    try {
      systemController.showLoading();

      String email = getCurrentUser()?.email ?? '';

      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        setErrorMessage(LocaleKeys.errorWrongPassword.tr());
        systemController.showError(LocaleKeys.errorWrongPassword.tr());
        rethrow;
      } else {
        setErrorMessage(e.message!);
      }
      rethrow;
    } finally {}
  }

  Future<void> changePassword(BuildContext context, String password) async {
    final systemController =
        Provider.of<SystemController>(context, listen: false);

    try {
      systemController.showLoading();

      await _auth.currentUser?.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      setErrorMessage(e.message!);
      rethrow;
    } finally {}
  }
}
