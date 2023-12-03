import 'dart:ui';

import 'package:my_stock/app/domain/model/emotion.dart';
import 'package:my_stock/core/constants/emotion.dart';
import 'package:my_stock/core/theme/color_theme.dart';

enum EmotionVMEnum {
  happier,
  happy,
  neutral,
  sad,
  sadder,
  notFilled,
  ;

  factory EmotionVMEnum.fromEmotion(Emotion e) {
    if (e == Emotion.happier) {
      return EmotionVMEnum.happier;
    } else if (e == Emotion.happy) {
      return EmotionVMEnum.happy;
    } else if (e == Emotion.neutral) {
      return EmotionVMEnum.neutral;
    } else if (e == Emotion.sad) {
      return EmotionVMEnum.sad;
    } else if (e == Emotion.sadder) {
      return EmotionVMEnum.sadder;
    } else {
      throw Exception("Emotion에 해당하는 EmotionVMEnum이 없습니다.");
    }
  }

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

  EmotionEnum get toEmotionEnum {
    if (this == EmotionVMEnum.happier) {
      return EmotionEnum.happier;
    } else if (this == EmotionVMEnum.happy) {
      return EmotionEnum.happy;
    } else if (this == EmotionVMEnum.neutral) {
      return EmotionEnum.neutral;
    } else if (this == EmotionVMEnum.sad) {
      return EmotionEnum.sad;
    } else if (this == EmotionVMEnum.sadder) {
      return EmotionEnum.sadder;
    } else {
      throw Exception("EmotionVM에 해당하는 EmotionEnum이 없습니다.");
    }
  }

  String get text {
    if (this == EmotionVMEnum.happier) {
      return "Excited";
    } else if (this == EmotionVMEnum.happy) {
      return "Joyous";
    } else if (this == EmotionVMEnum.neutral) {
      return "Depressed";
    } else if (this == EmotionVMEnum.sad) {
      return "Stressed";
    } else if (this == EmotionVMEnum.sadder) {
      return "Anxious";
    }
    throw Exception("EmotionVM에 해당하는 텍스트가 없습니다.");
  }
}
