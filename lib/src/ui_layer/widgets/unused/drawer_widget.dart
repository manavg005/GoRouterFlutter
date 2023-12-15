// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/colors.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/icons.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';
import 'package:keypitkleen_flutter_admin/src/ui_layer/widgets/app_text.dart';

class CustomDrawer extends StatefulWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const CustomDrawer(
      {super.key, required this.onItemSelected, required this.selectedIndex});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: LinearBorder.start(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        color: AppColors.mainColor,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.mainColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcons.appIcon,
                  AppStyles.sbWidth4,
                  const PoppinsNormal500(
                    text: "KeyPitKleen",
                    fontSize: 20,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
            buildListTile(AppIcons.dashboardIcon, 'Dashboard', 0, () {
              widget.onItemSelected(0);
            }),
            AppStyles.sbHeight10,
            buildListTile(AppIcons.profileIcon, 'User Management', 1, () {
              widget.onItemSelected(1);
            }),
            AppStyles.sbHeight10,
            buildListTile(AppIcons.cleanerIcon, 'Cleaner Management', 2, () {
              widget.onItemSelected(2);
            }),
            AppStyles.sbHeight10,
            buildListTile(AppIcons.bookingIcon, 'Booking Management', 3, () {
              widget.onItemSelected(3);
            }),
            AppStyles.sbHeight10,
            buildListTile(AppIcons.paymentIcon, 'Payment Management', 4, () {
              widget.onItemSelected(4);
            }),
            AppStyles.sbHeight10,
            buildListTile(
                AppIcons.notificationIcon, 'Notification Management', 5, () {
              widget.onItemSelected(5);
            }),
            AppStyles.sbHeight10,
            buildListTile(AppIcons.bannerIcon, 'Banner Management', 6, () {
              widget.onItemSelected(6);
            }),
            AppStyles.sbHeight10,
            buildListTile(AppIcons.profileIcon, 'Manage CMS', 7, () {
              widget.onItemSelected(7);
            }),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(
      Widget leadingIcon, String title, int index, VoidCallback onTap) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        color: widget.selectedIndex == index
            ? const Color.fromRGBO(255, 255, 255, 0.28)
            : AppColors.mainColor,
      ),
      child: ListTile(
        leading: leadingIcon,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
        onTap: () {
          // setState(() {
          //   _activeIndex = index; // Update the active index
          //   // GoRouter.of(context).go(routeName);
          // });
          onTap();
        },
        minLeadingWidth: 0,
      ),
    );
  }
}
