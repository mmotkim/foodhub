import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodhub/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: PhoneRoute.page),
        AutoRoute(page: VerificationRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: EmailSentFirebaseRoute.page),
        AutoRoute(page: RetypePasswordRoute.page),
        AutoRoute(page: NewPasswordRoute.page),
        AutoRoute(page: VerifyCodeRoute.page),
        CustomRoute(
          page: WelcomeRoute.page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
      ];
}
