// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppImages {
  /// svg images - start ------------------------------------------------------
  /// svg images - end --------------------------------------------------------
  /// asset images - start ------------------------------------------------------
  static Image welcomeImage = Image.asset(
    'images/welcome.png',
    fit: BoxFit.fill,
  );

  static Image bannerImage = Image.asset(
    'images/home_screen_banner.png',
    fit: BoxFit.fill,
  );

  static Widget personGif = Image.asset(
    'images/person_gif.gif',
    fit: BoxFit.scaleDown,
  );
  static Image cleanerGif = Image.asset(
    'images/cleaner_gif.gif',
  );
  static Image bookingGif = Image.asset(
    'images/booking_gif.gif',
  );
  static Image revenueGif = Image.asset(
    'images/revenue_gif.gif',
  );

  /// asset images - end --------------------------------------------------------
}
