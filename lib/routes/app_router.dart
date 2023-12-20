import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: InitialRoute.page, initial: true),
        AutoRoute(page: CompleteUserSignUpRoute.page),
        AutoRoute(page: AddNewDeviceRoute.page),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignupRoute.page),
        AutoRoute(page: CheckEmailAddressRoute.page),
        AutoRoute(page: VerificationCodeRoute.page),
        AutoRoute(page: SignUpFormRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          children: [
            AutoRoute(page: DashboardRoute.page, initial: true),
            AutoRoute(page: DevicesRoute.page),
            AutoRoute(page: AgentsRoute.page),
          ],
        ),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: EditProfile.page),
      ];
}
