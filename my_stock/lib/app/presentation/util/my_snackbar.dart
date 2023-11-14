import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_stock/app/presentation/util/navigator_key.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';

abstract class MySnackBar {
  static void show(String msg) {
    FToast fToast = FToast();
    fToast.init(NavigatorKey.key.currentContext!);
    fToast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: EmotionColor.happier,
        ),
        child: Text(
          msg,
          style: HeaderTextStyle.nanum16.white,
        ),
      ),
      toastDuration: const Duration(seconds: 1),
    );
  }
}
