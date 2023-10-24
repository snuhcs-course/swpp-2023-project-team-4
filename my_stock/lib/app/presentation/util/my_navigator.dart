import 'package:flutter/material.dart';

import 'navigator_key.dart';

abstract class MyNavigator {
  static void toNamed(String routeName) {
    BuildContext context = NavigatorKey.key.currentContext!;
    Navigator.pushNamed(context, routeName);
  }

  static void pushReplacementNamed(String routeName) {
    BuildContext context = NavigatorKey.key.currentContext!;
    Navigator.pushReplacementNamed(context, routeName);
  }

  static void pop() {
    BuildContext context = NavigatorKey.key.currentContext!;
    Navigator.pop(context);
  }
}
