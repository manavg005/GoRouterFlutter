import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/utils/responsive.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/key_pit_kleen_app.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/change_password_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/banner_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/cleaner_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/send_notification_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/popup_menu.dart';
import 'package:keypitkleen_flutter_admin/src/business_layer/utils/helper/cookies_helper.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/booking_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/dashboard_screen.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/notification_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/payment_management.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/user_management.dart';

class ScaffoldWithDrawer extends StatefulWidget {
  const ScaffoldWithDrawer({
    super.key,
  });
  // final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithDrawer> createState() => _ScaffoldWithDrawerState();
}

class _ScaffoldWithDrawerState extends State<ScaffoldWithDrawer> {
  // int _currentIndex = 0;
  static List<MyCustomNavBarItem> tabs = [
    MyCustomNavBarItem(
      icon: AppIcons.dashboardIcon,
      selectedIcon: const Icon(Icons.home),
      label: const PoppinsNormal500(
        text: "Dashboard",
        fontSize: 16,
        color: Colors.white,
      ),
      initialLocation: '/dashboard',
    ),
    MyCustomNavBarItem(
      icon: AppIcons.profileIcon,
      selectedIcon: const Icon(Icons.calendar_month),
      label: const Text('User Management'),
      initialLocation: '/user',
    ),
    MyCustomNavBarItem(
      icon: AppIcons.cleanerIcon,
      selectedIcon: const Icon(Icons.home),
      label: const Text('Cleaner Management'),
      initialLocation: '/cleaner',
    ),
    MyCustomNavBarItem(
      icon: AppIcons.bookingIcon,
      selectedIcon: const Icon(Icons.home),
      label: const Text('Booking Management'),
      initialLocation: '/booking',
    ),
    MyCustomNavBarItem(
      icon: AppIcons.paymentIcon,
      selectedIcon: const Icon(Icons.home),
      label: const Text('Payment Management'),
      initialLocation: '/payment',
    ),
    MyCustomNavBarItem(
      icon: AppIcons.notificationIcon,
      selectedIcon: const Icon(Icons.home),
      label: const Text('Notification Management'),
      initialLocation: '/notification',
    ),
    MyCustomNavBarItem(
      icon: AppIcons.bannerIcon,
      selectedIcon: const Icon(Icons.home),
      label: const Text('Banner Management'),
      initialLocation: '/banner',
    ),
  ];

  List<GlobalKey<NavigatorState>> navigatorKeys =
      List.generate(tabs.length, (index) => GlobalKey<NavigatorState>());

  final List<Widget> destinations = [
    const DashboardScreen(),
    const UserManagementScreen(),
    const SendNotificationScreen(),
    const BookingManagementScreen(),
    const PaymentManagementScreen(),
    const NotificationManagementScreen(),
    const BannerManagementScreen(),
    const ChangePasswordScreen(),
  ];
  //
  @override
  void initState() {
    super.initState();
    CookieManager.addToCookie("drawerIndex", "0");
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BaseWidget(
      body: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Container(
                  padding: AppStyles.pd30,
                  width: screenSize.width / 4.9,
                  color: AppColors.mainColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcons.appIcon,
                      AppStyles.sbWidth4,
                      Responsive.isDesktop(context)
                          ? const PoppinsNormal500(
                              text: "KeyPitKleen",
                              fontSize: 20,
                              color: AppColors.whiteColor,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: _buildNavigationRail()),
              ],
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  AppBar(
                    // elevation: 50,
                    backgroundColor: AppColors.whiteColor,
                    actions: const [
                      PopUpMenu(),
                    ],
                  ),
                  Expanded(
                    child: destinations[
                        int.parse(CookieManager.getCookie("drawerIndex"))],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationRail() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var screenSize = MediaQuery.of(context).size;
        bool isWideScreen =
            constraints.maxWidth > 600; // Adjust the breakpoint as needed

        return SizedBox(
          width: isWideScreen ? screenSize.width / 4.9 : 10,
          child: NavigationRail(
            // key: navigatorKey,
            key: navigatorKeys[
                int.parse(CookieManager.getCookie("drawerIndex"))],
            backgroundColor: AppColors.mainColor,
            extended: Responsive.isDesktop(context),
            labelType: NavigationRailLabelType.none,
            selectedIndex: int.parse(CookieManager.getCookie("drawerIndex")),
            onDestinationSelected: (int index) {
              _goOtherTab(context, index);
            },
            destinations: tabs,
            unselectedLabelTextStyle: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            selectedLabelTextStyle: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            indicatorColor: Colors.black,
            // unselectedIconTheme: const IconThemeData(color: Colors.black26),
          ),
        );
      },
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == CookieManager.getCookie("drawerIndex")) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;
    if (index == 7) {
      router.push(location);
    } else {
      // Push the route onto the appropriate NavigatorState
      navigatorKeys[index].currentState?.pushReplacementNamed(location);
    }

    setState(
      () {
        CookieManager.addToCookie("drawerIndex", index.toString());
        router.go(location);
      },
    );
  }
}

class MyCustomNavBarItem extends NavigationRailDestination {
  final String initialLocation;

  const MyCustomNavBarItem(
      {required this.initialLocation,
      required Widget icon,
      required Widget label,
      required Icon selectedIcon})
      : super(icon: icon, label: label);
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:keypitkleen_flutter_admin/src/business_layer/utils/responsive.dart';
// import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
// import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
// import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
// import 'package:keypitkleen_flutter_admin/src/key_pit_kleen_app.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/change_password_screen.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/banner_management.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/cleaner_management.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/send_notification_screen.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/base_widget.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/popup_menu.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/booking_management.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/dashboard_screen.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/notification_management/notification_management.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/payment_management.dart';
// import 'package:keypitkleen_flutter_admin/src/ui_layer/screens/home_screen/user_management.dart';

// class ScaffoldWithDrawer extends StatefulWidget {
//   const ScaffoldWithDrawer({super.key});
//
//   @override
//   State<ScaffoldWithDrawer> createState() => _ScaffoldWithDrawerState();
// }
//
// class _ScaffoldWithDrawerState extends State<ScaffoldWithDrawer> {
//   int _selectedTabIndex = 0;
//
//   static List<MyCustomNavBarItem> tabs = [
//     MyCustomNavBarItem(
//       icon: AppIcons.dashboardIcon,
//       selectedIcon: const Icon(Icons.home),
//       label: const PoppinsNormal500(
//         text: "Dashboard",
//         fontSize: 16,
//         color: Colors.white,
//       ),
//       initialLocation: '/dashboard',
//     ),
//     MyCustomNavBarItem(
//       icon: AppIcons.profileIcon,
//       selectedIcon: const Icon(Icons.calendar_month),
//       label: const Text('User Management'),
//       initialLocation: '/user',
//     ),
//     MyCustomNavBarItem(
//       icon: AppIcons.cleanerIcon,
//       selectedIcon: const Icon(Icons.home),
//       label: const Text('Cleaner Management'),
//       initialLocation: '/cleaner',
//     ),
//     MyCustomNavBarItem(
//       icon: AppIcons.bookingIcon,
//       selectedIcon: const Icon(Icons.home),
//       label: const Text('Booking Management'),
//       initialLocation: '/booking',
//     ),
//     MyCustomNavBarItem(
//       icon: AppIcons.paymentIcon,
//       selectedIcon: const Icon(Icons.home),
//       label: const Text('Payment Management'),
//       initialLocation: '/payment',
//     ),
//     MyCustomNavBarItem(
//       icon: AppIcons.notificationIcon,
//       selectedIcon: const Icon(Icons.home),
//       label: const Text('Notification Management'),
//       initialLocation: '/notification',
//     ),
//     MyCustomNavBarItem(
//       icon: AppIcons.bannerIcon,
//       selectedIcon: const Icon(Icons.home),
//       label: const Text('Banner Management'),
//       initialLocation: '/banner',
//     ),
//   ];
//
//   List<GlobalKey<NavigatorState>> navigatorKeys =
//       List.generate(tabs.length, (index) => GlobalKey<NavigatorState>());
//
//   final List<Widget> destinations = [
//     const DashboardScreen(),
//     const UserManagementScreen(),
//     const CleanerManagementScreen(),
//     const BookingManagementScreen(),
//     const PaymentManagementScreen(),
//     const NotificationManagementScreen(),
//     const BannerManagementScreen(),
//     const ChangePasswordScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return BaseWidget(
//       body: PreferredSize(
//         preferredSize: Size(screenSize.width, 1000),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   padding: AppStyles.pd30,
//                   width: screenSize.width / 4.9,
//                   color: AppColors.mainColor,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       AppIcons.appIcon,
//                       AppStyles.sbWidth4,
//                       Responsive.isDesktop(context)
//                           ? const PoppinsNormal500(
//                               text: "KeyPitKleen",
//                               fontSize: 20,
//                               color: AppColors.whiteColor,
//                             )
//                           : const SizedBox.shrink(),
//                     ],
//                   ),
//                 ),
//                 Expanded(flex: 2, child: _buildNavigationRail()),
//               ],
//             ),
//             Expanded(
//               flex: 5,
//               child: Column(
//                 children: [
//                   AppBar(
//                     backgroundColor: AppColors.whiteColor,
//                     actions: const [
//                       PopUpMenu(),
//                     ],
//                   ),
//                   Expanded(
//                     child: destinations[_selectedTabIndex],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavigationRail() {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         var screenSize = MediaQuery.of(context).size;
//         bool isWideScreen = constraints.maxWidth > 600;
//
//         return SizedBox(
//           width: isWideScreen ? screenSize.width / 4.9 : 10,
//           child: NavigationRail(
//             key: navigatorKey,
//             backgroundColor: AppColors.mainColor,
//             extended: Responsive.isDesktop(context),
//             labelType: NavigationRailLabelType.none,
//             selectedIndex: _selectedTabIndex,
//             onDestinationSelected: (int index) {
//               _goOtherTab(context, index);
//             },
//             destinations: tabs,
//             unselectedLabelTextStyle: const TextStyle(
//                 color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
//             selectedLabelTextStyle: const TextStyle(
//                 color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
//             indicatorColor: Colors.black,
//           ),
//         );
//       },
//     );
//   }
//
//   void _goOtherTab(BuildContext context, int index) {
//     if (index == _selectedTabIndex) return;
//     GoRouter router = GoRouter.of(context);
//     String location = tabs[index].initialLocation;
//     if (index == 7) {
//       router.push(location);
//     } else {
//       // Push the route onto the appropriate NavigatorState
//       navigatorKeys[index].currentState?.pushReplacementNamed(location);
//     }
//
//     setState(() {
//       _selectedTabIndex = index;
//       router.go(location);
//     });
//   }
// }
//
// class MyCustomNavBarItem extends NavigationRailDestination {
//   final String initialLocation;
//
//   const MyCustomNavBarItem({
//     required this.initialLocation,
//     required Widget icon,
//     required Widget label,
//     required Icon selectedIcon,
//   }) : super(icon: icon, label: label);
// }
