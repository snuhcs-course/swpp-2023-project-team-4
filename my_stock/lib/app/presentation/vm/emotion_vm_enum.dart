import 'dart:ui';

import 'package:my_stock/core/theme/color_theme.dart';

enum EmotionVMEnum {
  happier,
  happy,
  neutral,
  sad,
  sadder,
  notFilled,
  ;

  Color get color {
    if (this == EmotionVMEnum.happier) {
      return EmotionColor.happier;
    } else if (this == EmotionVMEnum.happy) {
      return EmotionColor.happy;
    } else if (this == EmotionVMEnum.neutral) {
      return EmotionColor.neutral;
    } else if (this == EmotionVMEnum.sad) {
      return EmotionColor.sad;
    } else if (this == EmotionVMEnum.sadder) {
      return EmotionColor.sadder;
    } else if (this == EmotionVMEnum.notFilled) {
      return EmotionColor.notFilled;
    } else {
      throw Exception("EmotionVM에 해당하는 색상이 없습니다.");
    }
  }
}
