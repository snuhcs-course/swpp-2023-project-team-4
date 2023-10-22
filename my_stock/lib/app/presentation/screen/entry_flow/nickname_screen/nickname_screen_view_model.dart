import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_0_main_indexed_stack_screen/main_indexed_stack_screen.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';

class NicknameScreenViewModel extends ChangeNotifier {
    void onArrowButtonClicked() {
    MyNavigator.toNamed(MainIndexedStackScreen.routeName);
  }