// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/styles.dart';

import 'colors.dart';

class AppIcons {
  /// svg images - start ------------------------------------------------------
  // static Widget homeIcon = SvgPicture.asset(
  //   "assets/icons/home.svg",
  //   color: AppColors.whiteColor.withOpacity(0.6),
  // );

  static Widget emailIcon = Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: SvgPicture.asset(
      "/icons/email_icon.svg",
      height: AppStyles.getHeight(19),
      width: AppStyles.getWidth(19),
      color: AppColors.textFieldLabelColor,
    ),
  );

  static Widget passwordIcon = SvgPicture.asset(
    "/icons/password_icon.svg",
  );

  static Widget searchIcon = SvgPicture.asset(
    "/icons/search-normal.svg",
  );

  static Widget appIcon = SvgPicture.asset(
    "/icons/app_logo.svg",
    height: 44,
    width: 44,
  );

  static Widget notificationIcon = SvgPicture.asset(
    "/icons/notification_bell.svg",
    color: AppColors.whiteColor,
  );
  static Widget arrowDown = SvgPicture.asset(
    "/icons/arrow-down.svg",
    height: 18,
    width: 18,
  );

  static Widget profileIcon = SvgPicture.asset(
    "/icons/profile.svg",
    color: AppColors.whiteColor,
  );

  static Widget cleanerIcon = SvgPicture.asset(
    "/icons/cleaner_icon.svg",
    color: AppColors.whiteColor,
  );

  static Widget bookingIcon = SvgPicture.asset(
    "/icons/booking_icon.svg",
    color: AppColors.whiteColor,
  );

  static Widget dashboardIcon = SvgPicture.asset(
    "/icons/dashboard_icon.svg",
    color: AppColors.whiteColor,
  );

  static Widget paymentIcon = SvgPicture.asset(
    "/icons/payment_icon.svg",
    color: AppColors.whiteColor,
  );

  static Widget bannerIcon = SvgPicture.asset(
    "/icons/banner_icon.svg",
    color: AppColors.whiteColor,
  );

  /// svg images - end --------------------------------------------------------

  /// asset images - start ------------------------------------------------------
  static Image splashAnimation = Image.asset(
    'assets/images/splash_screen_gif.gif',
  );

  /// asset images - end --------------------------------------------------------
}
