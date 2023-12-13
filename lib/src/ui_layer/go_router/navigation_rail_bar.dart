// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/utils/responsive.dart';

import '../../data_layer/res/styles.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
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
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: <NavigationDestination>[
          NavigationDestination(
            label: "Dashboard",
            icon: AppIcons.dashboardIcon,
          ),
          NavigationDestination(
            label: "User Management",
            icon: AppIcons.profileIcon,
          ),
          NavigationDestination(
            label: "Cleaner Management",
            icon: AppIcons.cleanerIcon,
          ),
          NavigationDestination(
            label: "Booking Management",
            icon: AppIcons.bookingIcon,
          ),
          NavigationDestination(
            label: "Payment Management",
            icon: AppIcons.paymentIcon,
          ),
          NavigationDestination(
            label: "Notification Management",
            icon: AppIcons.notificationIcon,
          ),
          NavigationDestination(
            label: "Banner Management",
            icon: AppIcons.bannerIcon,
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
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
                      unselectedLabelTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      selectedLabelTextStyle: TextStyle(
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
                          ),
                          icon: AppIcons.cleanerIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Booking Management",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          icon: AppIcons.bookingIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Payment Management",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          icon: AppIcons.paymentIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Notification Management",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          icon: AppIcons.notificationIcon,
                        ),
                        NavigationRailDestination(
                          label: const PoppinsNormal500(
                            text: "Banner Management",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          icon: AppIcons.bannerIcon,
                        ),
                      ],
                      unselectedIconTheme: IconThemeData(color: Colors.white),
                      selectedIconTheme: IconThemeData(color: Colors.white),
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
