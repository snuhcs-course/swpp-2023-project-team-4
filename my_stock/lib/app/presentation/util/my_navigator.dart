import 'package:flutter/material.dart';

import 'navigator_key.dart';

abstract class MyNavigator {
  static Future<T?> toNamed<T extends Object?>(String routeName) {
    BuildContext context = NavigatorKey.key.currentContext!;
    return Navigator.pushNamed<T?>(context, routeName);
  }

  static Future<T?> push<T extends Object?>(Widget widget, {String? name}) {
    BuildContext context = NavigatorKey.key.currentContext!;
    return Navigator.push<T?>(
      context,
      MaterialPageRoute(
          settings: name != null ? RouteSettings(name: name) : null, builder: (context) => widget),
    );
  }

  static Future<T?> pushReplacementNamed<T extends Object?>(String routeName) {
    BuildContext context = NavigatorKey.key.currentContext!;
    return Navigator.pushReplacementNamed(context, routeName);
  }

  static void pop<T extends Object?>([T? result]) {
    BuildContext context = NavigatorKey.key.currentContext!;
    Navigator.pop(context, result);
  }
}
