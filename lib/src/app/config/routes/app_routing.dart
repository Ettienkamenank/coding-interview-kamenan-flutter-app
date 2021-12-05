import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouting {
  static changeScreen(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  static changeScreenWithRoute({
    required BuildContext context,
    required Widget screen,
    PageTransitionType? transitionType,
  }) {
    Navigator.push(
      context,
      PageTransition(
        child: screen,
        type: transitionType ?? PageTransitionType.rightToLeftWithFade,
      ),
    );
    // Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static changeScreenWithRouteAndRemove({
    required BuildContext context,
    required Widget screen,
    PageTransitionType? transitionType,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: screen,
        type: transitionType ?? PageTransitionType.rightToLeftWithFade,
      ),
      (route) => false,
    );
  }

  static changeScreenWithArgument(
      BuildContext context, String route, Object? arguments) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  static changeScreenAndRemove(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

  static backToPrevious(BuildContext context) {
    Navigator.pop(context);
    // Navigator.of(context).maybePop();
  }
}
