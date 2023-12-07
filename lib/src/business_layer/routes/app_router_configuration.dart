import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/route_names.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/banner_management/add_banner_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/banner_management/banner_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/booking_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/change_password_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/cleaner_management/cleaner_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/dashboard_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/payment_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/user_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/login_screen/login_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/notification_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/send_notification_screen.dart';
import 'package:keypitkleen_flutter_admin/main.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/go_router/navigation_rail_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/dashboard',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final loggedIn = await UserStateHiveHelper.instance.getIsUserLoggedIn();
    // final isLogging = state.path == '/login';
    if (!loggedIn) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      builder: (context, state) {
        return const LoginScreen();
      },
      redirect: (context, state) async {
        final loggedIn = await UserStateHiveHelper.instance.getIsUserLoggedIn();
        if (loggedIn) {
          return '/dashboard';
        }
        return null;
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/dashboard',
              name: RouteNames.dashboard,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DashboardScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'change-password',
                  name: RouteNames.changePasswordScreen,
                  builder: (context, state) => const ChangePasswordScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorBKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/user-management',
              name: RouteNames.userManagement,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: UserManagementScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorCKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/cleaner-management',
              name: RouteNames.cleanerManagement,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CleanerManagementScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorDKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/booking-management',
              name: RouteNames.bookingManagement,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: BookingManagementScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorEKey,
          routes: [
            GoRoute(
              path: '/payment-management',
              name: RouteNames.paymentManagement,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: PaymentManagementScreen()),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorFKey,
          routes: [
            GoRoute(
              path: '/notification-management',
              name: RouteNames.notificationManagement,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: NotificationManagementScreen(
                    detailsPath:
                        '/notification-management/send-new-notification'),
              ),
              routes: [
                GoRoute(
                  path: 'send-new-notification',
                  name: RouteNames.sendNewNotification,
                  builder: (context, state) => const SendNotificationScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _shellNavigatorGKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/banner-management',
              name: RouteNames.bannerManagement,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: BannerManagementScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'add-banner',
                  name: RouteNames.addBanner,
                  builder: (context, state) => const AddBannerScreen(),
                ),
              ],
            ),
          ],
        ),
/*        StatefulShellBranch(
          navigatorKey: _shellNavigatorGKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/g',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'B', detailsPath: '/g/details'),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),*/
      ],
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
      child: Center(
    child: Text(state.error.toString()),
  )),
);
