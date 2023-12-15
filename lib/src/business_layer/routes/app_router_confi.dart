import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/change_password_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/login_screen/forgot_password_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/banner_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/booking_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/trash/cleaner_managemen_trasht.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/dashboard_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/notification_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/payment_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/user_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/login_screen/login_screen.dart';

import '../../ui_layer/widgets/scaffold_drawer.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
bool _isAuth = false;

final router = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // StatefulShellRoute.indexedStack(
    //     builder: (context, state, navigationShell) {
    //       return ScaffoldWithDrawer(navigationShell: navigationShell);
    //     },
    //     branches: []),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithDrawer(
          state: state,
          child: child,
        );
      },
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/dashboard',
          pageBuilder: (context, state) {
            return _pageBuilder(DashboardScreen(), state: state);
          },
          // builder: (context, state) {
          //   return const DashboardScreen();
          // },
          // redirect: (context, state) async {
          //   if (await UserStateHiveHelper.instance.getIsUserLoggedIn()) {
          //     log("in dashboard");
          //     return "/dashboard";
          //   } else {
          //     log("in login");
          //     return "/login";
          //   }
          // },
          routes: [
            GoRoute(
              name: 'change-password',
              path: 'change-password',
              builder: (context, state) {
                return const ChangePasswordScreen();
              },
            ),
          ],
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/user',
          pageBuilder: (context, state) {
            return _pageBuilder(UserManagementScreen(), state: state);
          },
          // builder: (context, state) {
          //   return const UserManagementScreen();
          // },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/cleaner',
          pageBuilder: (context, state) {
            return _pageBuilder(CleanerManagementScreen(), state: state);
          },
          // builder: (context, state) {
          //   return const CleanerManagementScreen();
          // },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/payment',
          // builder: (context, state) {
          //   return const PaymentManagementScreen();
          // },
          pageBuilder: (context, state) {
            return _pageBuilder(PaymentManagementScreen(), state: state);
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/booking',
          pageBuilder: (context, state) {
            return _pageBuilder(BookingManagementScreen(), state: state);
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/notification',
          pageBuilder: (context, state) {
            return _pageBuilder(NotificationManagementScreen(), state: state);
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/banner',
          pageBuilder: (context, state) {
            return _pageBuilder(BannerManagementScreen(), state: state);
          },
        ),
      ],
    ),
    // GoRoute(
    //   name: 'change-password',
    //   path: '/dashboard/change-password',
    //   builder: (context, state) {
    //     return const ChangePasswordScreen();
    //   },
    // ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
      },
      redirect: (context, state) async {
        if (await UserStateHiveHelper.instance.getIsUserLoggedIn()) {
          log("in dashboard");
          return "/dashboard";
        } else {
          log("in login");
          return "/login";
        }
      },
    ),
    GoRoute(
      name: 'forgot-password',
      path: '/forgot-password',
      builder: (context, state) {
        return const ForgetPasswordScreen();
      },
    ),
  ],
);

Future<bool> setUserAsLoggedIn() async {
  bool isLoggedIn = await UserStateHiveHelper.instance.getIsUserLoggedIn();
  return isLoggedIn;
}

Page<dynamic> _pageBuilder(Widget page, {required GoRouterState state}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      child: child,
    ),
  );
}
