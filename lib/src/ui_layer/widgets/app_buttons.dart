// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data_layer/res/colors.dart';
import '../../data_layer/res/numbers.dart';
import '../../data_layer/res/styles.dart';

/// this is a custom button that animates on tap
/// if [shrinkOnTapHold] is true, the button will shrink on tap and expand on release
/// if [shrinkOnTapHold] is false, the button will expand on tap and shrink on release
/// if [loading] is true, the button will show a loading widget
/// if [loading] is false, the button will show the [title] or [child]
class AnimatedButton extends StatefulWidget {
  AnimatedButton({
    super.key,
    this.title = 'Animated Button',
    this.child,
    this.onPressed,
    this.titleTextStyle,
    this.titleTextAlign = TextAlign.center,
    this.width = 200,
    this.height = 50,
    this.loadingWidth = 50,
    this.loadingHeight = 50,
    this.widthChangeOnHold = 4,
    this.heightChangeOnHold = 1,
    this.shrinkOnTapHold = false,
    this.borderRadius = 10,
    this.loadingWidget,
    this.padding = const EdgeInsets.all(10),
    this.hapticFeedback,
    this.loading = false,
    this.disabled = false,
    this.buttonColor = Colors.blue,
    this.disabledButtonColor = Colors.grey,
    this.loaderColor = Colors.white,
    this.disabledButtonOpacity = 0.5,
    this.buttonAnimationDuration = 100,
    this.childAnimationDuration = 200,
    this.shadow,
    this.buttonBorderColor,
  }) /* : assert(width > 0 && height > 0),
        assert(loadingWidth > 0 && loadingHeight > 0),
        assert(padding.isNonNegative),
        assert(borderRadius >= 0)*/
  ;

  /// the title of the button
  /// if [child] is passed, then the [title] will not be shown
  /// you can use [child] to pass a widget to show on the button
  final String title;

  /// the style of the title
  final TextStyle? titleTextStyle;

  /// the alignment of the title
  final TextAlign titleTextAlign;

  /// button default width
  double width;

  /// button default height
  double height;

  /// loading width
  /// this is the width of the button when it is in loading state
  /// means [loading] is true
  final double loadingWidth;

  /// loading height
  /// this is the height of the button when it is in loading state
  /// means [loading] is true
  final double loadingHeight;

  /// the amount of width the button changes on tap hold
  final double widthChangeOnHold;

  /// the amount of height the button changes on tap hold
  final double heightChangeOnHold;

  /// if true, the button will shrink on tap hold and expand on release
  /// if false, the button will expand on tap hold and shrink on release
  /// default is false
  final bool shrinkOnTapHold;

  /// the border radius of the button
  final double borderRadius;

  /// user can pass a widget to show on the button
  /// if child is passed, then the [title] will not be shown
  final Widget? child;

  /// the widget to show when loading
  final Widget? loadingWidget;

  /// the padding of the button
  final EdgeInsets padding;

  /// the haptic feedback of the button
  final HapticFeedback? hapticFeedback;

  /// if true, the button will show the loading widget
  /// if false, the button will show the title
  bool loading = false;

  /// the function to call when the button is pressed
  final VoidCallback? onPressed;

  /// is the button disabled
  bool disabled = false;

  /// button color
  Color? buttonColor, disabledButtonColor, loaderColor, buttonBorderColor;

  /// disable button color opacity
  double disabledButtonOpacity;

  /// animation durations in milliseconds
  /// the duration of the button animation
  /// the duration of the child animation
  int buttonAnimationDuration, childAnimationDuration;

  List<BoxShadow>? shadow;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  // loading
  // bool loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onDoubleTap: () {},
      // onDoubleTapCancel: () {},
      onLongPress: () {},
      onPanDown: (details) {
        if (widget.disabled) return;

        /// haptic feedback
        widget.hapticFeedback;

        /// shrink or expand
        // setState(() {
        //   if (widget.shrinkOnTapHold) {
        //     widget.width -= widget.widthChangeOnHold;
        //     widget.height -= widget.heightChangeOnHold;
        //   } else {
        //     widget.width += widget.widthChangeOnHold;
        //     widget.height += widget.heightChangeOnHold;
        //   }
        // });
      },
      onPanEnd: (details) {
        if (widget.disabled) return;

        /// haptic feedback
        widget.hapticFeedback;

        /// shrink or expand
        // setState(() {
        //   if (widget.shrinkOnTapHold) {
        //     widget.width += widget.widthChangeOnHold;
        //     widget.height += widget.heightChangeOnHold;
        //   } else {
        //     widget.width -= widget.widthChangeOnHold;
        //     widget.height -= widget.heightChangeOnHold;
        //   }
        // });
      },
      onTap: () {
        if (widget.disabled) return;

        /// haptic feedback
        widget.hapticFeedback;

        /// call the function
        widget.onPressed?.call();

        /// shrink or expand
        // setState(() {
        //   if (widget.shrinkOnTapHold) {
        //     widget.width += widget.widthChangeOnHold;
        //     widget.height += widget.heightChangeOnHold;
        //   } else {
        //     widget.width -= widget.widthChangeOnHold;
        //     widget.height -= widget.heightChangeOnHold;
        //   }
        // });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.buttonAnimationDuration),
        padding: widget.padding,

        /// if loading is true, then the button will show the loading widget
        /// else it will show the title or child
        width: widget.loading ? widget.loadingWidth : widget.width,

        /// if loading is true, then the button will show the loading widget
        /// else it will show the title or child
        height: widget.loading ? widget.loadingHeight : widget.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: (widget.disabled)
                ? widget.disabledButtonColor
                        ?.withOpacity(widget.disabledButtonOpacity) ??
                    Colors.transparent
                : widget.buttonBorderColor ?? Colors.transparent,
            width: 1,
          ),
          boxShadow: widget.shadow,
          color: (widget.disabled)
              ? widget.disabledButtonColor
                  ?.withOpacity(widget.disabledButtonOpacity)
              : widget.buttonColor,
          borderRadius: BorderRadius.circular(
              widget.loading ? widget.borderRadius * 10 : widget.borderRadius),
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: widget.childAnimationDuration),
          child: (widget.loading) ? _loader() : widget.child ?? defaultChild(),
        ),
      ),
    );
  }

  /// the title of the button, returns a [Text] widget
  Text _text() {
    return Text(
      widget.title,
      style: widget.titleTextStyle,
    );
  }

  /// the loading widget, returns a [Center] widget
  /// with [widget.loadingWidget] as child
  Center _loader() {
    return Center(
      child: widget.loadingWidget ??
          CircularProgressIndicator(
            color: widget.loaderColor,
          ),
    );
  }

  /// the child of the button
  /// if [loading] is true, the button will show [_loader]
  /// if [loading] is false, the button will show [_text]
  Widget defaultChild() {
    return widget.loading ? _loader() : _text();
  }
}

// -------------------------------------------------------------------------
/// default app button - no animation ---------------------------------------------
class CommonAppButton extends StatelessWidget {
  const CommonAppButton({
    Key? key,
    required this.onTap,
    this.alignment,
    this.active = true,
    this.buttonColor = AppColors.themeGreenColor,
    this.textColor = AppColors.whiteColor,
    this.fontWeight = FontWeight.w600,
    this.fontSize = d_16,
    this.borderColor,
    required this.text,
    this.radius = d_10,
    this.padding,
    this.textHeight = onePointFive,
    this.buttonColorOpacity = 0.9,
    this.splashColor = AppColors.blackColor,
    this.isLoading = false,
  }) : super(key: key);
  final void Function() onTap;
  final bool active;
  final AlignmentGeometry? alignment;

  final Color buttonColor;
  final Color textColor;
  final Color? borderColor;
  final FontWeight fontWeight;
  final double fontSize;
  final String text;
  final double radius;
  final double textHeight;
  final EdgeInsetsGeometry? padding;
  final double buttonColorOpacity;
  final Color splashColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        splashColor:
            active ? splashColor : AppColors.themeGreenColor.withOpacity(0),
        onTap: active ? onTap : () {},
        child: Container(
          padding: padding ?? AppStyles.pd15,
          alignment: alignment ?? Alignment.center,
          decoration: AppStyles.appButtonBoxDecoration(
            buttonColor.withOpacity(buttonColorOpacity),
            active: active,
            radius: radius,
            borderColor: active ? borderColor : Colors.transparent,
          ),
          child: (isLoading)
              ? const CupertinoActivityIndicator(
                  color: AppColors.themeGreenColor,
                )
              : Text(
                  text,
                  style: AppStyles.subtitleStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor,
                    height: textHeight,
                  ),
                ),
        ),
      ),
    );
  }
}
