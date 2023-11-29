import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/date_emotion.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/core/util/date.dart';

class ReportScreenViewModel with ChangeNotifier {
  Date startDate = Date.now().firstDayOfWeek;
  Date endDate = Date.now().friday;

  (int, int, int) get selectedNthWeek => startDate.nthWeek;

  void setDate(Date startDate, Date endDate) {
    this.startDate = startDate;
    this.endDate = endDate;
    notifyListeners();
  }

  List<Date> get dates {
    List<Date> dates = [];
    Date date = startDate;
    dates.add(date);
    while (date != endDate) {
      date = date.add(Duration(days: 1));
      dates.add(date);
    }
    return dates;
  }

  List<DateEmotionVM> get dateEmotions {
    List<DateEmotionVM> dateEmotionVMs = [];
    for (Date date in dates) {
      dateEmotionVMs.add(DateEmotionVM(date: date, emotion: EmotionVMEnum.values[date.day % 5]));
    }
    dateEmotionVMs[4].emotion = null;
    // dateEmotionVMs.removeLast();
    // dateEmotionVMs.add(DateEmotionVM(date: endDate, emotion: null));
    return dateEmotionVMs;
  }
}
