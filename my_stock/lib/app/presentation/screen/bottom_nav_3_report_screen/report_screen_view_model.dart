import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/model/day_record.dart';
import 'package:my_stock/app/domain/model/emotion_return_rate.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/repository_interface/report_repository.dart';
import 'package:my_stock/app/domain/use_case/fetch_emotion_records_use_case.dart';
import 'package:my_stock/app/domain/use_case/fetch_emotion_return_rate_use_case.dart';
import 'package:my_stock/app/presentation/screen/bottom_nav_2_calendar_screen/date_emotion.dart';
import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/core/util/date.dart';

Date getStartDate() {
  Date currentDate = Date.now();
  if (currentDate <= currentDate.friday) {
    return currentDate.firstDayOfWeek.subtract(Duration(days: 7));
  }
  return currentDate.firstDayOfWeek;
}

Date getEndDate() {
  Date currentDate = Date.now();
  if (currentDate <= currentDate.friday) {
    return currentDate.friday.subtract(Duration(days: 7));
  }
  return currentDate.friday;
}

class ReportScreenViewModel with ChangeNotifier {
  ReportScreenViewModel() {
    _fetchEmotionReturnRates();
  }

  Date startDate = getStartDate();
  Date endDate = getEndDate();

  (int, int, int) get selectedNthWeek => startDate.nthWeek;
  Map<int, double> map = {};

  void setDate(Date startDate, Date endDate) {
    this.startDate = startDate;
    this.endDate = endDate;
    _fetchEmotionReturnRates();
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

  final FetchEmotionReturnRateUseCase _fetchEmotionReturnRateUseCase =
      FetchEmotionReturnRateUseCase(
    reportRepository: GetIt.I<ReportRepository>(),
  );

  bool isEmotionReturnRateLoading = true;

  void _fetchEmotionReturnRates() {
    isEmotionReturnRateLoading = true;
    notifyListeners();
    _fetchEmotionReturnRateUseCase(
      startDate: startDate,
      endDate: endDate,
      onSuccess: (List<EmotionReturnRate> emotionReturnRates) {
        isEmotionReturnRateLoading = false;
        map = {};
        for (EmotionReturnRate emotionReturnRate in emotionReturnRates) {
          map[EmotionVMEnum.fromEmotion(emotionReturnRate.emotion).number] =
              emotionReturnRate.returnRate;
        }
        notifyListeners();
      },
    );
  }

  List<DateEmotionVM> get dateEmotions {
    List<DateEmotionVM> dateEmotionVMs = [];
    for (Date date in dates) {
      dateEmotionVMs.add(DateEmotionVM(date: date, emotion: EmotionVMEnum.values[date.day % 5]));
    }
    dateEmotionVMs[endDate.day % 5].emotion = null;
    return dateEmotionVMs;
  }

  final FetchEmotionRecordsUseCase _fetchEmotionRecordsUseCase =
      FetchEmotionRecordsUseCase(GetIt.I<EmotionRepository>());

  void _fetchEmotionRecords() {
    _fetchEmotionRecordsUseCase(
      startDate: startDate,
      endDate: endDate,
      onSuccess: (List<DayRecord> dayRecords) {
        for (DayRecord dayRecord in dayRecords) {
          DateEmotionVM dateEmotionVM =
              dateEmotions.firstWhere((dateEmotionVM) => dateEmotionVM.date == dayRecord.date);
          dateEmotionVM.emotion = EmotionVMEnum.fromEmotion(dayRecord.emotion);
        }
        notifyListeners();
      },
    );
  }
}
