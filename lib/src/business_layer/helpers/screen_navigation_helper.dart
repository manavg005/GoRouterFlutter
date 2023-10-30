import 'package:flutter/material.dart';

import '../../data_layer/res/numbers.dart';

enum TransitionType {
  slide,
  fade,
  scale,
  rotate,
  size,
  rightToLeft,
  leftToRight,
  bottomToTop,
}

class ScreenNavigation {
  /* Function used to create custom animated route */
  static Route createRoute(Widget widget,
      {TransitionType transitionType = TransitionType.fade,
      String routeName = "",
      Map<String, String>? routeArgs}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName, arguments: routeArgs),
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(d_1, d_0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        switch (transitionType) {
          case TransitionType.slide:
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.rotate:
            return RotationTransition(turns: animation, child: child);
          case TransitionType.size:
            return SizeTransition(sizeFactor: animation, child: child);
          case TransitionType.rightToLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(d_1, d_0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.leftToRight:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-d_1, d_0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case TransitionType.bottomToTop:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(d_0, d_1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          default: // TransitionType.slide
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
        }
      },
    );
  }
}
