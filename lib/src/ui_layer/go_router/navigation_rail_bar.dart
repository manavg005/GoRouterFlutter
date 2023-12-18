import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/utils/responsive.dart';

import '../../data_layer/res/styles.dart';

class ScaffoldWithNestedNavigation extends StatefulWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.state,
    required this.child,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));

  final GoRouterState state;
  final Widget child;

  @override
  State<ScaffoldWithNestedNavigation> createState() =>
      _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState
    extends State<ScaffoldWithNestedNavigation> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return LayoutBuilder(builder: (context, constraints) {
      return ScaffoldWithNavigationRail(
          body: widget.child,
          selectedIndex: widget.state.fullPath == "/dashboard"
              ? 0
              : widget.state.fullPath == "/user"
                  ? 1
                  : widget.state.fullPath == "/dashboard/change-password"
                      ? 0
                      : widget.state.fullPath == "/cleaner"
                          ? 2
                          : widget.state.fullPath == "/booking"
                              ? 3
                              : widget.state.fullPath == "/payment"
                                  ? 4
                                  : widget.state.fullPath == "/notification"
                                      ? 5
                                      : widget.state.fullPath == "/banner"
                                          ? 6
                                          : widget.state.fullPath ==
                                                  "/notification/send-new-notification"
                                              ? 5
                                              : (widget.state.fullPath ==
                                                          "/banner") ||
                                                      (widget.state.fullPath ==
                                                          "/banner/add-banner")
                                                  ? 6
                                                  : 9,
          onDestinationSelected: (int index) {
            switch (index) {
              case 0:
                context.go('/dashboard');
                // if you were using currentIndex, then you'd have to change it
                // here
                _currentIndex = index;
              case 1:
                context.go('/user');
                _currentIndex = index;
              // and here
              case 2:
                context.go('/cleaner');
                _currentIndex = index;
              // and here
              case 3:
                context.go('/booking');
                // if you were using currentIndex, then you'd have to change it
                // here
                _currentIndex = index;
              case 4:
                context.go('/payment');
                _currentIndex = index;
              // and here
              case 5:
                context.go('/notification');
                _currentIndex = index;
              // and here
              case 6:
                context.go('/banner');
                _currentIndex = index;
              // and here
            }
          });
      // }
    });
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Container(
                  padding: AppStyles.pd30,
                  width: screenSize.width / 5,
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
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: screenSize.width / 5,
                    child: NavigationRail(
                      selectedIndex: selectedIndex,
                      onDestinationSelected: onDestinationSelected,
                      extended: Responsive.isDesktop(context),
                      labelType: Responsive.isDesktop(context)
                          ? NavigationRailLabelType.none
                          : Responsive.isTablet(context)
                              ? NavigationRailLabelType.all
                              : NavigationRailLabelType.none,
                      backgroundColor: AppColors.mainColor,
                      unselectedLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      selectedLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      destinations: <NavigationRailDestination>[
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Dashboard",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          icon: AppIcons.dashboardIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "User Management",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          icon: AppIcons.profileIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Cleaner Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.cleanerIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Booking Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.bookingIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Payment Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.paymentIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Notification Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.notificationIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Banner Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.bannerIcon,
                        ),
                      ],
                      unselectedIconTheme:
                          const IconThemeData(color: Colors.white),
                      selectedIconTheme:
                          const IconThemeData(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

/*
                      destinations: <NavigationRailDestination>[
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Dashboard",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          icon: AppIcons.dashboardIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "User Management",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          icon: AppIcons.profileIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Cleaner Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.cleanerIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Booking Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.bookingIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Payment Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.paymentIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Notification Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.notificationIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Banner Management",
                            fontSize: 16,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: AppIcons.bannerIcon,
                        ),
                      ],

 */
