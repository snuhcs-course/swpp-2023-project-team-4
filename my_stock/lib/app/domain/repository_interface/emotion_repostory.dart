import 'package:my_stock/app/domain/model/day_record.dart';
import 'package:my_stock/app/domain/model/emotion.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/core/util/date.dart';

abstract class EmotionRepository {
  Future<Result<void, CreateEmotionIssue>> createEmotionRecord({
    required Date date,
    required EmotionEnum emotion,
    required String text,
  });

  Future<Result<List<DayRecord>, DefaultIssue>> getEmotionRecords({
    required int year,
    required int month,
  });

  Future<Result<List<DayRecord>, DefaultIssue>> getEmotionRecordsByDateRange({
    required Date startDate,
    required Date endDate,
  });
}

enum CreateEmotionIssue {
  beforeThisWeek,
  unknown,
}

abstract class EmotionRepositoryFactory {
  EmotionRepository createEmotionRepository();
}
