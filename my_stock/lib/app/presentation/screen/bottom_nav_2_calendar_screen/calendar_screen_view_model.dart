import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/date_emotion.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/core/util/date.dart';

class CalendarScreenViewModel with ChangeNotifier {
  List<DateEmotionVM> dateEmotionList = [
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 1,
      ),
      emotion: EmotionVMEnum.happy,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 2,
      ),
      emotion: EmotionVMEnum.sad,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 3,
      ),
      emotion: EmotionVMEnum.happier,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 4,
      ),
      emotion: EmotionVMEnum.happy,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 5,
      ),
      emotion: EmotionVMEnum.sad,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 6,
      ),
      emotion: EmotionVMEnum.neutral,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 7,
      ),
      emotion: EmotionVMEnum.happy,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 8,
      ),
      emotion: EmotionVMEnum.sad,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 9,
      ),
      emotion: EmotionVMEnum.neutral,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 10,
      ),
      emotion: EmotionVMEnum.happy,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 11,
      ),
      emotion: EmotionVMEnum.sad,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 12,
      ),
      emotion: EmotionVMEnum.sadder,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 13,
      ),
      emotion: EmotionVMEnum.sadder,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 14,
      ),
      emotion: EmotionVMEnum.notFilled,
    ),
    DateEmotionVM(
      date: Date(
        year: 2023,
        month: 10,
        day: 15,
      ),
      emotion: EmotionVMEnum.notFilled,
    ),
    DateEmotionVM(),
    DateEmotionVM(),
    DateEmotionVM(),
    DateEmotionVM(),
    DateEmotionVM(),
    DateEmotionVM(),
  ];
}