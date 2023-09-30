import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouterHelper {
  RouterHelper._();

  static RouterHelper routerHelper = RouterHelper._();
  GlobalKey<NavigatorState> routerKey = GlobalKey<NavigatorState>();

  routingToSpecificWidget(Widget widget) {
    BuildContext context = routerKey.currentState!.context;
    routerKey.currentState!.pushReplacement(PageTransition(
        child: (widget),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 0)));
  }

  routingToSpecificWidgetWithoutPop(Widget widget) {
    BuildContext context = routerKey.currentState!.context;
    routerKey.currentState!.push(PageTransition(
        child: (widget),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 0)));
  }

  routingReplacement(Widget widget) {
    BuildContext context = routerKey.currentState!.context;
    routerKey.currentState!.pushReplacement(PageTransition(
        child: (widget),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 0)));
  }

  routingReplacementUntil(Widget widget) {
    BuildContext context = routerKey.currentState!.context;
    routerKey.currentState!.pushAndRemoveUntil(
        PageTransition(
            child: (widget),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 0)),
            (Route<dynamic> route) => false);
  }
}
