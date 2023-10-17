// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:foodhub/views/email_verification/email_sent_api.dart' as _i1;
import 'package:foodhub/views/email_verification/verify_code.dart' as _i12;
import 'package:foodhub/views/home_screen/home_screen.dart' as _i3;
import 'package:foodhub/views/login/login.dart' as _i4;
import 'package:foodhub/views/phone_screen/phone.dart' as _i6;
import 'package:foodhub/views/phoneVerification/phone_verify.dart' as _i11;
import 'package:foodhub/views/reset_password/email_sent_firebase.dart' as _i2;
import 'package:foodhub/views/reset_password/new_password.dart' as _i5;
import 'package:foodhub/views/reset_password/reset_password.dart' as _i7;
import 'package:foodhub/views/reset_password/retype_password.dart' as _i8;
import 'package:foodhub/views/signup/signup.dart' as _i9;
import 'package:foodhub/views/splash.dart' as _i10;
import 'package:foodhub/views/welcome/welcome.dart' as _i13;

abstract class $AppRouter extends _i14.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    EmailSentApiRoute.name: (routeData) {
      final args = routeData.argsAs<EmailSentApiRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.EmailSentApiScreen(
          key: args.key,
          email: args.email,
          isLoggedIn: args.isLoggedIn,
        ),
      );
    },
    EmailSentFirebaseRoute.name: (routeData) {
      final args = routeData.argsAs<EmailSentFirebaseRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.EmailSentFirebaseScreen(
          key: args.key,
          email: args.email,
          isLoggedIn: args.isLoggedIn,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginScreen(),
      );
    },
    NewPasswordRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.NewPasswordScreen(),
      );
    },
    PhoneRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PhoneScreen(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.ResetPasswordScreen(
          key: args.key,
          isLoggedIn: args.isLoggedIn,
        ),
      );
    },
    RetypePasswordRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RetypePasswordScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SignUpScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SplashScreen(),
      );
    },
    VerificationRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.VerificationScreen(),
      );
    },
    VerifyCodeRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyCodeRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.VerifyCodeScreen(
          key: args.key,
          email: args.email,
          isLoggedIn: args.isLoggedIn,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.EmailSentApiScreen]
class EmailSentApiRoute extends _i14.PageRouteInfo<EmailSentApiRouteArgs> {
  EmailSentApiRoute({
    _i15.Key? key,
    required String email,
    required bool isLoggedIn,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          EmailSentApiRoute.name,
          args: EmailSentApiRouteArgs(
            key: key,
            email: email,
            isLoggedIn: isLoggedIn,
          ),
          initialChildren: children,
        );

  static const String name = 'EmailSentApiRoute';

  static const _i14.PageInfo<EmailSentApiRouteArgs> page =
      _i14.PageInfo<EmailSentApiRouteArgs>(name);
}

class EmailSentApiRouteArgs {
  const EmailSentApiRouteArgs({
    this.key,
    required this.email,
    required this.isLoggedIn,
  });

  final _i15.Key? key;

  final String email;

  final bool isLoggedIn;

  @override
  String toString() {
    return 'EmailSentApiRouteArgs{key: $key, email: $email, isLoggedIn: $isLoggedIn}';
  }
}

/// generated route for
/// [_i2.EmailSentFirebaseScreen]
class EmailSentFirebaseRoute
    extends _i14.PageRouteInfo<EmailSentFirebaseRouteArgs> {
  EmailSentFirebaseRoute({
    _i15.Key? key,
    required String email,
    required bool isLoggedIn,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          EmailSentFirebaseRoute.name,
          args: EmailSentFirebaseRouteArgs(
            key: key,
            email: email,
            isLoggedIn: isLoggedIn,
          ),
          initialChildren: children,
        );

  static const String name = 'EmailSentFirebaseRoute';

  static const _i14.PageInfo<EmailSentFirebaseRouteArgs> page =
      _i14.PageInfo<EmailSentFirebaseRouteArgs>(name);
}

class EmailSentFirebaseRouteArgs {
  const EmailSentFirebaseRouteArgs({
    this.key,
    required this.email,
    required this.isLoggedIn,
  });

  final _i15.Key? key;

  final String email;

  final bool isLoggedIn;

  @override
  String toString() {
    return 'EmailSentFirebaseRouteArgs{key: $key, email: $email, isLoggedIn: $isLoggedIn}';
  }
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i5.NewPasswordScreen]
class NewPasswordRoute extends _i14.PageRouteInfo<void> {
  const NewPasswordRoute({List<_i14.PageRouteInfo>? children})
      : super(
          NewPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPasswordRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PhoneScreen]
class PhoneRoute extends _i14.PageRouteInfo<void> {
  const PhoneRoute({List<_i14.PageRouteInfo>? children})
      : super(
          PhoneRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ResetPasswordScreen]
class ResetPasswordRoute extends _i14.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i15.Key? key,
    required bool isLoggedIn,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            isLoggedIn: isLoggedIn,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i14.PageInfo<ResetPasswordRouteArgs> page =
      _i14.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.isLoggedIn,
  });

  final _i15.Key? key;

  final bool isLoggedIn;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, isLoggedIn: $isLoggedIn}';
  }
}

/// generated route for
/// [_i8.RetypePasswordScreen]
class RetypePasswordRoute extends _i14.PageRouteInfo<void> {
  const RetypePasswordRoute({List<_i14.PageRouteInfo>? children})
      : super(
          RetypePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'RetypePasswordRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SignUpScreen]
class SignUpRoute extends _i14.PageRouteInfo<void> {
  const SignUpRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SplashScreen]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i11.VerificationScreen]
class VerificationRoute extends _i14.PageRouteInfo<void> {
  const VerificationRoute({List<_i14.PageRouteInfo>? children})
      : super(
          VerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerificationRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i12.VerifyCodeScreen]
class VerifyCodeRoute extends _i14.PageRouteInfo<VerifyCodeRouteArgs> {
  VerifyCodeRoute({
    _i15.Key? key,
    required String email,
    required bool isLoggedIn,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          VerifyCodeRoute.name,
          args: VerifyCodeRouteArgs(
            key: key,
            email: email,
            isLoggedIn: isLoggedIn,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyCodeRoute';

  static const _i14.PageInfo<VerifyCodeRouteArgs> page =
      _i14.PageInfo<VerifyCodeRouteArgs>(name);
}

class VerifyCodeRouteArgs {
  const VerifyCodeRouteArgs({
    this.key,
    required this.email,
    required this.isLoggedIn,
  });

  final _i15.Key? key;

  final String email;

  final bool isLoggedIn;

  @override
  String toString() {
    return 'VerifyCodeRouteArgs{key: $key, email: $email, isLoggedIn: $isLoggedIn}';
  }
}

/// generated route for
/// [_i13.WelcomeScreen]
class WelcomeRoute extends _i14.PageRouteInfo<void> {
  const WelcomeRoute({List<_i14.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}
