import 'package:auto_route/auto_route.dart';
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
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: EmailSentRoute.page),
        AutoRoute(page: EmailSentRoute2.page),
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
      ];
}
