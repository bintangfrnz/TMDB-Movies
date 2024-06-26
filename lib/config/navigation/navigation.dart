import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyNav {
  static pushNamedAndRemoveUntil(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  static pushReplacementNamed(String newRouteName, {Object? arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed(
      newRouteName,
      arguments: arguments,
    );
  }

  static pushNamed(String routeName, {Object? arguments, Function()? action}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments)
        .then((_) => action?.call());
  }

  static pop() => navigatorKey.currentState?.pop();
}
