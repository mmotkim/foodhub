import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/api_auth_controller.dart';
import 'package:foodhub/database/prefs_provider.dart';
import 'package:foodhub/models/user_entity.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:provider/provider.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  bool _loggedIn = false;
  bool _needMailVerify = false;
  bool useFirebaseAuth = false;
  UserEntity? userData;
  String? errorMessage;
  bool get loggedIn => _loggedIn;
  bool get needMailVerify => _needMailVerify;

  // Set functions for loggedIn and needMailVerify
  set setLoggedIn(bool value) {
    _loggedIn = value;
    notifyListeners();
  }

  set setNeedMailVerify(bool value) {
    _needMailVerify = value;
    notifyListeners();
  }

  void switchAuth(bool value) {
    useFirebaseAuth = value;
    debugPrint('Use Firebase Auth: $value');
    notifyListeners();
  }

  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void clearErrorMessage() {
    errorMessage = null;
    notifyListeners();
  }

  Future<bool> _useFirebase() async {
    if (await PrefsProvider.getToken() != null) {
      switchAuth(false);
      return false;
    } else {
      switchAuth(true);
      return true;
    }
  }

  Future<void> init([BuildContext? context]) async {
    //ALSO CHECK IF EMAIL VERIFIED
    // FirebaseUIAuth.configureProviders([
    //   EmailAuthProvider(),
    // ]);
    await _useFirebase()
        ? FirebaseAuth.instance.authStateChanges().listen((user) async {
            if (user != null) {
              _loggedIn = true;
              switchAuth(true);
              debugPrint('LOGGED IN GOT DAMMIT');
              final providerName = await getProviderName(user);
              if (!user.emailVerified && providerName == 'Email/Password') {
                _needMailVerify = true;
                debugPrint('EMAIL NEED VERIFICATION GOT DAMMIT');
              }
            } else {
              _loggedIn = false;
              debugPrint('NOT LOGGED IN');
            }
          })
        : {
            if (context != null)
              {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                  await _getProfile(context);
                })
              }
          };
    // : await  ApiAuthController().getProfile().then((value) {
    //     setLoggedIn = true;
    //     Logger().i('API LOGGED IN');
    //     setNeedMailVerify = !value.isVerifiedEmail;
    //     Logger().i('Need mail verify?: $needMailVerify');
    //     userData = value;
    //     notifyListeners();
    //   });
  }

  Future<void> _getProfile(BuildContext context) async {
    final sysController = context.read<SystemController>();
    final apiController = context.read<ApiAuthController>();
    try {
      //case 401 token expired
      // await PrefsProvider.saveToken(
      //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiY3VzdG9tIHRva2VuIiwiaWF0IjoxNjk3NTEwMjcxLCJleHAiOjE2OTc1MTAyOTF9.Ifq037zGT5Kp25CzIUcgvps2I9YuTwJjuXnttrJn-nk');
      //case 403 refreshToken also expired
      // await PrefsProvider.saveRefreshToken('69420');

      await apiController
          .getProfile()
          .then((value) => {
                setLoggedIn = true,
                setNeedMailVerify = !value.isVerifiedEmail,
                notifyListeners(),
              })
          .catchError((err) {
        throw err;
      });
    } on DioException catch (e) {
      sysController.handleDioException(e);

      setLoggedIn = false;
      notifyListeners();
    } catch (e) {
      setLoggedIn = false;
      notifyListeners();
    }
  }

  Future<String?> getProviderName(user) async {
    try {
      if (user != null) {
        for (UserInfo userInfo in user.providerData) {
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
      return null; // Handle errors gracefully
    }
  }
}
