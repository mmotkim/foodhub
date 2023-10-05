// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:foodhub/views/home_screen/home_screen.dart' as _i3;
import 'package:foodhub/views/login/login.dart' as _i4;
import 'package:foodhub/views/phone_screen/phone.dart' as _i5;
import 'package:foodhub/views/phoneVerification/phone_verify.dart' as _i9;
import 'package:foodhub/views/reset_password/email_sent.dart' as _i1;
import 'package:foodhub/views/reset_password/email_sent2.dart' as _i2;
import 'package:foodhub/views/reset_password/reset_password.dart' as _i6;
import 'package:foodhub/views/signup/signup.dart' as _i7;
import 'package:foodhub/views/splash.dart' as _i8;
import 'package:foodhub/views/welcome/welcome.dart' as _i10;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    EmailSentRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.EmailSentScreen(),
      );
    },
    EmailSentRoute2.name: (routeData) {
      final args = routeData.argsAs<EmailSentRoute2Args>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.EmailSentScreen2(
          key: args.key,
          emailSent: args.emailSent,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginScreen(),
      );
    },
    PhoneRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PhoneScreen(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ResetPasswordScreen(
          key: args.key,
          isLoggedIn: args.isLoggedIn,
        ),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SignUpScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SplashScreen(),
      );
    },
    VerificationRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.VerificationScreen(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.EmailSentScreen]
class EmailSentRoute extends _i11.PageRouteInfo<void> {
  const EmailSentRoute({List<_i11.PageRouteInfo>? children})
      : super(
          EmailSentRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmailSentRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.EmailSentScreen2]
class EmailSentRoute2 extends _i11.PageRouteInfo<EmailSentRoute2Args> {
  EmailSentRoute2({
    _i12.Key? key,
    required String emailSent,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          EmailSentRoute2.name,
          args: EmailSentRoute2Args(
            key: key,
            emailSent: emailSent,
          ),
          initialChildren: children,
        );

  static const String name = 'EmailSentRoute2';

  static const _i11.PageInfo<EmailSentRoute2Args> page =
      _i11.PageInfo<EmailSentRoute2Args>(name);
}

class EmailSentRoute2Args {
  const EmailSentRoute2Args({
    this.key,
    required this.emailSent,
  });

  final _i12.Key? key;

  final String emailSent;

  @override
  String toString() {
    return 'EmailSentRoute2Args{key: $key, emailSent: $emailSent}';
  }
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PhoneScreen]
class PhoneRoute extends _i11.PageRouteInfo<void> {
  const PhoneRoute({List<_i11.PageRouteInfo>? children})
      : super(
          PhoneRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ResetPasswordScreen]
class ResetPasswordRoute extends _i11.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i12.Key? key,
    required bool isLoggedIn,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            isLoggedIn: isLoggedIn,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i11.PageInfo<ResetPasswordRouteArgs> page =
      _i11.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.isLoggedIn,
  });

  final _i12.Key? key;

  final bool isLoggedIn;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, isLoggedIn: $isLoggedIn}';
  }
}

/// generated route for
/// [_i7.SignUpScreen]
class SignUpRoute extends _i11.PageRouteInfo<void> {
  const SignUpRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SplashScreen]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.VerificationScreen]
class VerificationRoute extends _i11.PageRouteInfo<void> {
  const VerificationRoute({List<_i11.PageRouteInfo>? children})
      : super(
          VerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerificationRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.WelcomeScreen]
class WelcomeRoute extends _i11.PageRouteInfo<void> {
  const WelcomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
