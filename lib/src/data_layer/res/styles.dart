import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keypitkleen_flutter_admin/src/data_layer/res/numbers.dart';

import '../../business_layer/helpers/device_info_helper.dart';
import 'colors.dart';

class AppStyles {
  static var appBarTitleTextStyle = TextStyle(
    fontSize: getFontSize(d_18),
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );

  static var listTileTitleTextStyle = TextStyle(
    fontSize: getFontSize(d_16),
    fontWeight: FontWeight.w500,
    color: AppColors.mainColor,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );
  static var nameTitleTextStyle = TextStyle(
    fontSize: getFontSize(d_16),
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );
  static var notificationTitle = TextStyle(
    fontSize: getFontSize(d_16),
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );
  static var notificationSubtitleTextStyle = TextStyle(
    fontSize: getFontSize(d_12),
    fontWeight: FontWeight.w400,
    color: AppColors.darkGray,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );
  static var listTileSubtitleTextStyle = TextStyle(
    fontSize: getFontSize(d_14),
    fontWeight: FontWeight.w400,
    color: AppColors.darkGray,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );

  static var w400Size10ColorDarkGray = TextStyle(
    fontSize: getFontSize(d_10),
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor,
  );

  static var w600Size10ColorDarkGray = TextStyle(
    fontSize: getFontSize(d_10),
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );

  static var w400Size10ColorWhite = TextStyle(
    fontSize: getFontSize(d_10),
    fontWeight: FontWeight.w400,
    color: AppColors.whiteColor,
  );

  static var w600Size10ColorWhite = TextStyle(
    fontSize: getFontSize(d_10),
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );

  static var hintTextStyle = TextStyle(
    fontSize: getFontSize(d_14),
    fontWeight: FontWeight.w400,
    color: AppColors.darkGray,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );

  static var chipSelectedTextStyle = TextStyle(
    fontSize: getFontSize(d_12),
    fontWeight: FontWeight.w400,
    color: AppColors.lightBlack,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );

  static var chipUnselectedTextStyle = TextStyle(
    fontSize: getFontSize(d_12),
    fontWeight: FontWeight.w400,
    color: AppColors.lightBlack,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );

  static var buttonTextStyle = TextStyle(
    fontSize: getFontSize(d_16),
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
    // fontFamily: FontFamily.fontFamilySourceSansPro,
  );

  /// Method used to get font size according to device
  static double getFontSize(double value) {
    return value;
  }

  /// Method used to get height according to device
  static double getHeight(double value) {
    return value;
  }

  /// Method used to get width according to device
  static double getWidth(double value) {
    return value;
  }

  /// Paddings
  static EdgeInsets pd0 = const EdgeInsets.all(d_0);
  static EdgeInsets pd1 = const EdgeInsets.all(d_1);
  static EdgeInsets pd2 = const EdgeInsets.all(d_2);
  static EdgeInsets pd3 = const EdgeInsets.all(d_3);
  static EdgeInsets pd4 = const EdgeInsets.all(d_4);
  static EdgeInsets pd5 = const EdgeInsets.all(d_5);
  static EdgeInsets pd6 = const EdgeInsets.all(d_6);
  static EdgeInsets pd7 = const EdgeInsets.all(d_7);
  static EdgeInsets pd8 = const EdgeInsets.all(d_8);
  static EdgeInsets pd9 = const EdgeInsets.all(d_9);
  static EdgeInsets pd10 = const EdgeInsets.all(d_10);
  static EdgeInsets pd11 = const EdgeInsets.all(d_11);
  static EdgeInsets pd12 = const EdgeInsets.all(d_12);
  static EdgeInsets pd13 = const EdgeInsets.all(d_13);
  static EdgeInsets pd14 = const EdgeInsets.all(d_14);
  static EdgeInsets pd15 = const EdgeInsets.all(d_15);
  static EdgeInsets pd16 = const EdgeInsets.all(d_16);
  static EdgeInsets pd17 = const EdgeInsets.all(d_17);
  static EdgeInsets pd18 = const EdgeInsets.all(d_18);
  static EdgeInsets pd19 = const EdgeInsets.all(d_19);
  static EdgeInsets pd20 = const EdgeInsets.all(d_20);
  static EdgeInsets pd23 = const EdgeInsets.all(d_23);
  static EdgeInsets pd24 = const EdgeInsets.all(d_24);
  static EdgeInsets pd25 = const EdgeInsets.all(d_25);
  static EdgeInsets pd30 = const EdgeInsets.all(d_30);
  static EdgeInsets pd31 = const EdgeInsets.all(d_31);
  static EdgeInsets pd35 = const EdgeInsets.all(d_35);
  static EdgeInsets pd40 = const EdgeInsets.all(d_40);
  static EdgeInsets pd45 = const EdgeInsets.all(d_45);
  static EdgeInsets pd50 = const EdgeInsets.all(d_50);
  static EdgeInsets pd100 = const EdgeInsets.all(d_100);
  static EdgeInsets pdT5 = const EdgeInsets.only(top: d_5);
  static EdgeInsets pdT8 = const EdgeInsets.only(top: d_8);
  static EdgeInsets pdT10 = const EdgeInsets.only(top: d_10);
  static EdgeInsets pdT15 = const EdgeInsets.only(top: d_15);
  static EdgeInsets pdL16 = const EdgeInsets.only(left: d_16);
  static EdgeInsets pdR16 = const EdgeInsets.only(right: d_16);
  static EdgeInsets pdR8 = const EdgeInsets.only(right: d_8);
  static EdgeInsets pdR5T9B9 =
      const EdgeInsets.only(right: d_5, top: 9, bottom: 9);
  static EdgeInsets pdL5T9B9 =
      const EdgeInsets.only(left: d_5, top: 9, bottom: 9);
  static const EdgeInsets pdH5 = EdgeInsets.symmetric(horizontal: d_5);
  static const EdgeInsets pdH6 = EdgeInsets.symmetric(horizontal: d_6);
  static const EdgeInsets pdH9 = EdgeInsets.symmetric(horizontal: d_9);
  static const EdgeInsets pdH13 = EdgeInsets.symmetric(horizontal: d_13);
  static const EdgeInsets pdH16V13 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_13);
  static const EdgeInsets pdH9V12 =
      EdgeInsets.symmetric(horizontal: d_9, vertical: d_12);
  static const EdgeInsets pdH16V10 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_10);
  static const EdgeInsets pdH1V10 =
      EdgeInsets.symmetric(horizontal: d_1, vertical: d_10);
  static const EdgeInsets pdH16V11 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_11);
  static const EdgeInsets pdH15 = EdgeInsets.symmetric(horizontal: d_15);
  static const EdgeInsets pdH16 = EdgeInsets.symmetric(horizontal: d_16);
  static const EdgeInsets pdH21V1 =
      EdgeInsets.symmetric(horizontal: d_21, vertical: d_1);
  static const EdgeInsets pdH21V4 =
      EdgeInsets.symmetric(horizontal: d_21, vertical: d_4);
  static const EdgeInsets pdH16V1 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_1);
  static const EdgeInsets pdH16V15 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_15);
  static const EdgeInsets pdH16V7 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_7);
  static const EdgeInsets pdH16V4 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_4);
  static const EdgeInsets pdHV1614 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_14);
  static const EdgeInsets pdHV160 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_0);
  static const EdgeInsets pdHV1624 =
      EdgeInsets.symmetric(horizontal: d_16, vertical: d_24);
  static const EdgeInsets pdV10 = EdgeInsets.symmetric(vertical: d_10);
  static const EdgeInsets pdV6 = EdgeInsets.symmetric(vertical: d_6);
  static const EdgeInsets pdV8 = EdgeInsets.symmetric(vertical: d_8);
  static const EdgeInsets pdV12 = EdgeInsets.symmetric(vertical: d_12);
  static const EdgeInsets pdV16 = EdgeInsets.symmetric(vertical: d_16);
  static const EdgeInsets pdH50 = EdgeInsets.symmetric(horizontal: d_50);
  static final EdgeInsets screenHorizontalPadding = EdgeInsets.symmetric(
    horizontal: DeviceInfo.smallDevice ? d_16 : d_20,
  );
  static const EdgeInsets textFieldContentPadding = EdgeInsets.symmetric(
    horizontal: d_20,
    vertical: d_20,
  );
  static final EdgeInsets locationTextFieldPadding = EdgeInsets.symmetric(
    horizontal: DeviceInfo.smallDevice ? d_10 : d_10,
    vertical: d_16,
  );

  /// Sized Box
  static final SizedBox sbHeight0 = SizedBox(height: getHeight(d_0));
  static final SizedBox sbHeight1 = SizedBox(height: getHeight(d_1));
  static final SizedBox sbHeight2 = SizedBox(height: getHeight(d_2));
  static final SizedBox sbHeight3 = SizedBox(height: getHeight(d_3));
  static final SizedBox sbHeight4 = SizedBox(height: getHeight(d_4));
  static final SizedBox sbHeight5 = SizedBox(height: getHeight(d_5));
  static final SizedBox sbHeight6 = SizedBox(height: getHeight(d_6));
  static final SizedBox sbHeight7 = SizedBox(height: getHeight(d_7));
  static final SizedBox sbHeight8 = SizedBox(height: getHeight(d_8));
  static final SizedBox sbHeight9 = SizedBox(height: getHeight(d_9));
  static final SizedBox sbHeight10 = SizedBox(height: getHeight(d_10));
  static final SizedBox sbHeight11 = SizedBox(height: getHeight(d_11));
  static final SizedBox sbHeight12 = SizedBox(height: getHeight(d_12));
  static final SizedBox sbHeight13 = SizedBox(height: getHeight(d_13));
  static final SizedBox sbHeight14 = SizedBox(height: getHeight(d_14));
  static final SizedBox sbHeight15 = SizedBox(height: getHeight(d_15));
  static final SizedBox sbHeight16 = SizedBox(height: getHeight(d_16));
  static final SizedBox sbHeight17 = SizedBox(height: getHeight(d_17));
  static final SizedBox sbHeight18 = SizedBox(height: getHeight(d_18));
  static final SizedBox sbHeight19 = SizedBox(height: getHeight(d_19));
  static final SizedBox sbHeight20 = SizedBox(height: getHeight(d_20));
  static final SizedBox sbHeight21 = SizedBox(height: getHeight(d_21));
  static final SizedBox sbHeight22 = SizedBox(height: getHeight(d_22));
  static final SizedBox sbHeight23 = SizedBox(height: getHeight(d_23));
  static final SizedBox sbHeight24 = SizedBox(height: getHeight(d_24));
  static final SizedBox sbHeight25 = SizedBox(height: getHeight(d_25));
  static final SizedBox sbHeight28 = SizedBox(height: getHeight(d_28));
  static final SizedBox sbHeight30 = SizedBox(height: getHeight(d_30));
  static final SizedBox sbHeight31 = SizedBox(height: getHeight(d_31));
  static final SizedBox sbHeight32 = SizedBox(height: getHeight(d_32));
  static final SizedBox sbHeight33 = SizedBox(height: getHeight(d_33));
  static final SizedBox sbHeight34 = SizedBox(height: getHeight(d_34));
  static final SizedBox sbHeight36 = SizedBox(height: getHeight(d_36));
  static final SizedBox sbHeight39 = SizedBox(height: getHeight(d_39));
  static final SizedBox sbHeight44 = SizedBox(height: getHeight(d_44));
  static final SizedBox sbHeight45 = SizedBox(height: getHeight(d_45));
  static final SizedBox sbHeight52 = SizedBox(height: getHeight(d_52));
  static final SizedBox sbHeight55 = SizedBox(height: getHeight(d_55));
  static final SizedBox sbHeight69 = SizedBox(height: getHeight(d_69));
  static final SizedBox sbHeight75 = SizedBox(height: getHeight(d_75));
  static final SizedBox sbHeight84 = SizedBox(height: getHeight(d_84));
  static final SizedBox sbHeight104 = SizedBox(height: getHeight(d_105));
  static final SizedBox sbHeight62 = SizedBox(height: getHeight(d_62));

  static final SizedBox sbWidth1 = SizedBox(width: getWidth(d_1));
  static final SizedBox sbWidth2 = SizedBox(width: getWidth(d_2));
  static final SizedBox sbWidth3 = SizedBox(width: getWidth(d_3));
  static final SizedBox sbWidth4 = SizedBox(width: getWidth(d_4));
  static final SizedBox sbWidth5 = SizedBox(width: getWidth(d_5));
  static final SizedBox sbWidth6 = SizedBox(width: getWidth(d_6));
  static final SizedBox sbWidth7 = SizedBox(width: getWidth(d_7));
  static final SizedBox sbWidth8 = SizedBox(width: getWidth(d_8));
  static final SizedBox sbWidth9 = SizedBox(width: getWidth(d_9));
  static final SizedBox sbWidth10 = SizedBox(width: getWidth(d_10));
  static final SizedBox sbWidth11 = SizedBox(width: getWidth(d_11));
  static final SizedBox sbWidth12 = SizedBox(width: getWidth(d_12));
  static final SizedBox sbWidth13 = SizedBox(width: getWidth(d_13));
  static final SizedBox sbWidth14 = SizedBox(width: getWidth(d_14));
  static final SizedBox sbWidth15 = SizedBox(width: getWidth(d_15));
  static final SizedBox sbWidth16 = SizedBox(width: getWidth(d_16));
  static final SizedBox sbWidth17 = SizedBox(width: getWidth(d_17));
  static final SizedBox sbWidth19 = SizedBox(width: getWidth(d_19));
  static final SizedBox sbWidth21 = SizedBox(width: getWidth(d_21));
  static final SizedBox sbWidth23 = SizedBox(width: getWidth(d_23));
  static final SizedBox sbWidth24 = SizedBox(width: getWidth(d_24));
  static final SizedBox sbWidth28 = SizedBox(width: getWidth(d_28));
  static final SizedBox sbWidth32 = SizedBox(width: getWidth(d_32));
  static final SizedBox sbWidth63 = SizedBox(width: getWidth(d_63));
  static final SizedBox bottomSpace = SizedBox(height: getHeight(d_20));
  static final SizedBox bottomSheetSpace = SizedBox(height: getHeight(d_34));

  /// Set the status bar color to the widget
  static void setStatusBarTheme(
      {Color bottomBarColor = AppColors.lightBackgroundColor,
      Color topBarColor = AppColors.lightBackgroundColor}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top bar color
        statusBarIconBrightness: Brightness.light, //top bar icons
        systemNavigationBarColor: bottomBarColor, //bottom bar color
        systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
      ),
    );
  }

  /// Method used to set device orientation of the app
  static void setDeviceOrientationOfApp() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Method used get app theme
  static ThemeData getAppTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      primaryColor: AppColors.lightBackgroundColor,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.primarySwatch,
      ).copyWith(
        secondary: AppColors.mainColor,
      ),
    );
  }

  /// Text styles
  static subtitleStyle(
      {Color color = AppColors.whiteColor,
      double fontSize = 12,
      FontWeight fontWeight = FontWeight.w400,
      double height = onePointFive,
      TextDecoration? decoration = TextDecoration.none}) {
    return TextStyle(
      fontSize: getFontSize(fontSize),
      fontWeight: fontWeight,
      color: color,
      height: height.h,
      decoration: decoration,
      // fontFamily: FontFamily.fontFamilySourceSansPro,
    );
  }

  static titleStyle(
      {Color color = AppColors.whiteColor,
      double fontSize = d_14,
      FontWeight fontWeight = FontWeight.w400,
      double height = onePointFive,
      TextDecoration? decoration = TextDecoration.none}) {
    return TextStyle(
      fontSize: getFontSize(fontSize),
      fontWeight: fontWeight,
      color: color,
      height: height.h,
      decoration: decoration,
      // fontFamily: FontFamily.fontFamilySourceSansPro,
    );
  }

  static RoundedRectangleBorder bottomSheetTopCornersShape() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(d_20),
        topRight: Radius.circular(d_20),
      ),
    );
  }

  static BoxDecoration appButtonBoxDecoration(Color color,
      {bool active = true, double radius = d_10, Color? borderColor}) {
    return BoxDecoration(
      color: active ? color : color.withOpacity(0.5),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(
        color: borderColor ?? color,
        width: d_1,
      ),
    );
  }

  static BoxDecoration appButtonBoxDecorationWithShadow(Color color,
      {bool active = true, double radius = d_10, Color? borderColor}) {
    return BoxDecoration(
      color: active ? color : color.withOpacity(0.5),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(
        color: borderColor ?? color,
        width: d_1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  static BoxDecoration appBookingDetailsContainerWithShadow(Color color,
      {bool active = true, double radius = d_15, Color? borderColor}) {
    return BoxDecoration(
      color: active ? color : color.withOpacity(0.5),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(
        color: borderColor ?? color,
        width: d_1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 60,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}
