import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/date_emotion.dart';
import 'package:my_stock/app/presentation/util/get_days_in_month.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/core/util/date.dart';
import 'package:my_stock/core/util/year_month.dart';

class CalendarScreenViewModel with ChangeNotifier {
  List<DateEmotionVM> dateEmotionList = [];
  Map<Date, bool> isSelectedMap = {};

  CalendarScreenViewModel() {
    setBlankCalendarDate();
  }

  YearMonth yearMonth = YearMonth(
    year: 2023,
    month: 10,
  );

  void setYearMonth(YearMonth yearMonth) {
    this.yearMonth = yearMonth;
    notifyListeners();
    setBlankCalendarDate();
  }

  void setBlankCalendarDate() {
    dateEmotionList.clear();
    isSelectedMap.clear();

    int days = getDaysInMonth(year: yearMonth.year, month: yearMonth.month);
    for (int i = 1; i <= days; i++) {
      Date date = Date(
        year: yearMonth.year,
        month: yearMonth.month,
        day: i,
      );
      dateEmotionList.add(DateEmotionVM(date: date, emotion: EmotionVMEnum.notFilled));
      isSelectedMap[date] = false;
    }

    DateTime firstDayOfMonth = DateTime(yearMonth.year, yearMonth.month, 1);
    int weekday = firstDayOfMonth.weekday % 7;
    for (int i = 0; i < weekday; i++) {
      dateEmotionList.insert(0, DateEmotionVM());
    }

    DateTime lastDayOfMonth = DateTime(yearMonth.year, yearMonth.month, days);
    weekday = lastDayOfMonth.weekday % 7;
    int count = 6 - weekday;
    for (int i = 0; i < count; i++) {
      dateEmotionList.add(DateEmotionVM());
    }

    notifyListeners();
  }

  void onCalendarDateSelected(Date date) {
    for (Date key in isSelectedMap.keys) {
      isSelectedMap[key] = false;
    }
    isSelectedMap[date] = true;
    notifyListeners();
  }

  void Function(EmotionVMEnum) onSelectEmotion(Date date) {
    return (EmotionVMEnum emotion) {
      for (int i = 0; i < dateEmotionList.length; i++) {
        if (dateEmotionList[i].date == date) {
          dateEmotionList[i] = DateEmotionVM(
            date: date,
            emotion: emotion,
          );
        }
      }
      notifyListeners();
    };
  }
}
