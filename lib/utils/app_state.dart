import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/api_auth_controller.dart';
import 'package:foodhub/database/prefs_provider.dart';
import 'package:logger/logger.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  bool _loggedIn = false;
  bool _needMailVerify = false;
  bool get loggedIn => _loggedIn;
  bool get needMailVerify => _needMailVerify;
  bool useFirebaseAuth = false;

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
    print('useFirebaseAuth: $value');
    notifyListeners();
  }

  Future<bool> _useFirebase() async {
    if (await PrefsProvider.getToken() != null) {
      switchAuth(false);
      return false;
    } else {
      return true;
    }
  }

  Future<void> init() async {
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
                print('$providerName provider name in init');
                _needMailVerify = true;
                debugPrint('EMAIL NEED VERIFICATION GOT DAMMIT');
              }
            } else {
              _loggedIn = false;
              debugPrint('NOT LOGGED IN');
            }
          })
        : await ApiAuthController().getProfile().then((value) {
            setLoggedIn = true;
            Logger().i('API LOGGED IN');
            setNeedMailVerify = !value.isVerifiedEmail;
            Logger().i('Need mail verify?: $needMailVerify');
            notifyListeners();
          });
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
      print('Error getting provider name: $e');
      return null; // Handle errors gracefully
    }
  }
}
