import 'package:flutter/cupertino.dart';

class RouteHelper {
  RouteHelper._();
  static final routeHelper = RouteHelper._();

  final navigatorKey = GlobalKey<NavigatorState>();

  pushNamed(String routeName) {
    navigatorKey.currentState.pushNamed(routeName);
  }

  pushReplacementNamed(String routeName) {
    navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  pop() {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop();
    }
  }

  popAndPushNamed(routeName) {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.popAndPushNamed(routeName);
    }
  }
}
