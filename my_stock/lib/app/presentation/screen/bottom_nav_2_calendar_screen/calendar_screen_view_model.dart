import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/day_record.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/use_case/fetch_month_records.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/date_emotion.dart';
import 'package:my_stock/app/presentation/util/get_days_in_month.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/core/constants/emotion.dart';
import 'package:my_stock/core/util/date.dart';
import 'package:my_stock/core/util/year_month.dart';

class CalendarScreenViewModel with ChangeNotifier {
  final FetchMonthRecordsUseCase _fetchMonthRecordsUseCase = FetchMonthRecordsUseCase(
    emotionRepository: GetIt.I<EmotionRepository>(),
  );
  List<DateEmotionVM> dateEmotionList = [];
  Map<Date, bool> isSelectedMap = {};

  CalendarScreenViewModel() {
    setBlankCalendarDate();
    fetchRecords();
  }

  YearMonth yearMonth = YearMonth(
    year: DateTime.now().year,
    month: DateTime.now().month,
  );

  void setYearMonth(YearMonth yearMonth) {
    this.yearMonth = yearMonth;
    notifyListeners();
    setBlankCalendarDate();
    fetchRecords();
  }

  void setBlankCalendarDate() {
    dateEmotionList.clear();
    isSelectedMap.clear();

    int days = getDaysInMonth(year: yearMonth.year, month: yearMonth.month);
    Date currentDate = Date.fromDateTime(DateTime.now());
    for (int i = 1; i <= days; i++) {
      Date date = Date(
        year: yearMonth.year,
        month: yearMonth.month,
        day: i,
      );
      EmotionVMEnum? fillEmotion = EmotionVMEnum.notFilled;
      if (date > currentDate) {
        fillEmotion = null;
      }
      dateEmotionList.add(DateEmotionVM(date: date, emotion: fillEmotion));
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

  void fetchRecords() {
    _fetchMonthRecordsUseCase(
      year: yearMonth.year,
      month: yearMonth.month,
      onSuccess: (records) {
        for (DateEmotionVM dateEmotion in dateEmotionList) {
          for (DayRecord record in records) {
            if (dateEmotion.date == record.date) {
              switch (record.emotion) {
                case (Emotion.happier):
                  dateEmotion.emotion = EmotionVMEnum.happier;
                  break;
                case (Emotion.happy):
                  dateEmotion.emotion = EmotionVMEnum.happy;
                  break;
                case (Emotion.neutral):
                  dateEmotion.emotion = EmotionVMEnum.neutral;
                  break;
                case (Emotion.sad):
                  dateEmotion.emotion = EmotionVMEnum.sad;
                  break;
                case (Emotion.sadder):
                  dateEmotion.emotion = EmotionVMEnum.sadder;
                  break;
              }
            }
          }
        }
        notifyListeners();
      },
    );
  }

  void updateDateEmotion(DateEmotionVM dateEmotion) {
    for (int i = 0; i < dateEmotionList.length; i++) {
      if (dateEmotionList[i].date == dateEmotion.date) {
        dateEmotionList[i] = dateEmotion;
      }
    }
    notifyListeners();
  }

  bool hasRecord(Date date) {
    for (DateEmotionVM dateEmotion in dateEmotionList) {
      if (dateEmotion.date == date) {
        return dateEmotion.emotion != null && dateEmotion.emotion != EmotionVMEnum.notFilled;
      }
    }
    return false;
  }
}
