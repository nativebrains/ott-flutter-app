import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (axisDirection == AxisDirection.down ||
        axisDirection == AxisDirection.up) {
      return GlowingOverscrollIndicator(
        color: Colors.greenAccent,
        axisDirection: axisDirection,
        child: child,
      );
    }
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
