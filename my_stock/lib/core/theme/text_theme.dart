import 'package:flutter/material.dart';

import 'color_theme.dart';

abstract class HeaderTextStyle {
  static TextStyle get nanum16 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get nanum18 => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );
}

abstract class BodyTextStyle {
  static TextStyle get nanum10 => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get nanum12Light => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get nanum14 => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
}

abstract class OtherTextStyle {
  static TextStyle get logo => TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        fontFamily: 'TiltNeon',
      );

  static TextStyle get button => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontFamily: 'Pretendard',
      );

  static TextStyle get guide => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Pretendard',
      );
}

extension MyTextColor on TextStyle {
  TextStyle get writeText => copyWith(
        color: TextColor.writeText,
      );

  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get white => copyWith(color: Colors.white);
}
