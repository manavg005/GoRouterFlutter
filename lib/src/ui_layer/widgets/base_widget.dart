import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data_layer/res/colors.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({
    Key? key,
    required this.body,
    this.padding,
    this.backgroundColor = AppColors.whiteColor,
    this.bottomNavigationBar,
    this.drawer,
    this.systemUiOverlayStyle,
    this.topSafeArea = true,
    this.bottomSafeArea = true,
    this.leftSafeArea = true,
    this.rightSafeArea = true,
    this.appBar,
    this.bottomSheet,
  }) : super(key: key);

  final Widget body;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final bool topSafeArea;
  final bool bottomSafeArea;
  final bool leftSafeArea;
  final bool rightSafeArea;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle ?? SystemUiOverlayStyle.dark,
        child: SafeArea(
            top: topSafeArea,
            bottom: bottomSafeArea,
            left: leftSafeArea,
            right: rightSafeArea,
            child: body),
      ),
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar,
      drawer: drawer,
    );
  }
}

class BaseWidgetWithAppBar extends StatelessWidget {
  const BaseWidgetWithAppBar({
    Key? key,
    required this.body,
    this.padding,
    this.backgroundColor = AppColors.whiteColor,
    this.bottomNavigationBar,
    this.systemUiOverlayStyle,
    this.topSafeArea = true,
    this.appBar,
    this.bottomSafeArea = true,
    this.leftSafeArea = true,
    this.rightSafeArea = true,
  }) : super(key: key);

  final Widget body;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final bool topSafeArea;
  final bool bottomSafeArea;
  final bool leftSafeArea;
  final PreferredSizeWidget? appBar;
  final bool rightSafeArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle ?? SystemUiOverlayStyle.dark,
        child: SafeArea(
            top: topSafeArea,
            bottom: bottomSafeArea,
            left: leftSafeArea,
            right: rightSafeArea,
            child: body),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
