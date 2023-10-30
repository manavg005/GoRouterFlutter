import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/app_route_constants.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/dashboard.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/home_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/login_screen.dart';

import '../../ui_layer/screens/forgot_password_screen.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  GoRouter goRoute = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/home",
    routes: <RouteBase>[
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return HomeScreen();
          },
          routes: [
            GoRoute(
                name: AppRouteConstants.home,
                path: '/home',
                builder: (context, state) {
                  return HomeScreen();
                },
                routes: [
                  GoRoute(
                    path: 'dashboard',
                    builder: (BuildContext context, GoRouterState state) {
                      return const DashboardScreen();
                    },
                  ),
                ]),
          ]),
      GoRoute(
          name: AppRouteConstants.login,
          path: '/login',
          // builder: (context, state) {
          //   return LoginScreen();
          // }
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: LoginScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          }),
      GoRoute(
          name: AppRouteConstants.forgotPassword,
          path: '/forgot-password',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: ForgetPasswordScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          })
    ],
    /*errorPageBuilder: (context, state) {
      return const MaterialPage(child: LoginScreen());
    },*/
  );
}

/*redirect: (context, state) {
if (!isAuth && state.path!.startsWith('/${AppRouteConstants.home}')) {
return context.namedLocation(AppRouteConstants.login);
} else {
return null;
}
},*/
