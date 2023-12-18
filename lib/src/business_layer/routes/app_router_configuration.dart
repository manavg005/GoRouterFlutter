import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/login_info.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/routes/route_names.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/banner_management/add_banner_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/banner_management/banner_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/booking_management/booking_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/change_password_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/cleaner_management/cleaner_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/payment_management/dashboard_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/payment_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/user_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/login_screen/forgot_password_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/login_screen/login_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/notification_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/send_notification_screen.dart';
import 'package:keypitkleen_flutter_admin/main.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/go_router/navigation_rail_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final loggedIn = await UserStateHiveHelper.instance.getIsUserLoggedIn();
    final dashboard = state.matchedLocation == '/';
    final isLogging = state.matchedLocation == '/login';
    final isForgot = state.matchedLocation == '/forgot';
    if (!loggedIn && isForgot) {
      return '/forgot';
    }
    if (!loggedIn) {
      return '/login';
    }
    if (loggedIn && isLogging) {
      return '/dashboard';
    }

    return null;
  },
  refreshListenable: LoginInfo.instance,
  routes: [
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      builder: (context, state) {
        return const LoginScreen();
      },
      // redirect: (context, state) async {
      //   final loggedIn = await UserStateHiveHelper.instance.getIsUserLoggedIn();
      //   // final isForgot = state.name == 'forgot';
      //   // log("$isForgot");
      //   // log("${state.fullPath}");
      //   if (loggedIn) {
      //     return '/dashboard';
      //   }
      //   return null;
      // },
    ),
    GoRoute(
      path: '/forgot',
      name: 'forgot',
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithNestedNavigation(
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
            path: '/notification',
            pageBuilder: (context, state) {
              return _pageBuilder(
                  NotificationManagementScreen(
                    nextPath: '/notification/send-new-notification',
                  ),
                  state: state);
            },
            routes: [
              GoRoute(
                path: 'send-new-notification',
                name: RouteNames.sendNewNotification,
                builder: (context, state) => const SendNotificationScreen(),
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/banner',
            pageBuilder: (context, state) {
              return _pageBuilder(
                  BannerManagementScreen(
                    nextPath: '/banner/add-banner',
                  ),
                  state: state);
            },
            routes: [
              GoRoute(
                path: 'add-banner',
                name: RouteNames.addBanner,
                builder: (context, state) => const AddBannerScreen(),
              ),
            ],
          ),
        ]
        /*branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/dashboard',
              name: RouteNames.dashboard,
              // redirect: (context, state) {
              //   log("Redirecting to dashboard");
              //   return '/dashboard';
              // },
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: UniqueKey(),
                  child: const DashboardScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'dashboard',
                  builder: (context, state) {
                    return const DashboardScreen();
                  },
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      key: UniqueKey(),
                      child: const DashboardScreen(),
                    );
                  },
                ),
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
        StatefulShellBranch(
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
        ),
      ],*/
        ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
      child: Center(
    child: Text(state.error.toString()),
  )),
);

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
