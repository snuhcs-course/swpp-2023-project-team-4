import 'package:my_stock/app/domain/model/day_record.dart';
import 'package:my_stock/app/domain/model/emotion.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/core/util/date.dart';

class MockEmotionRepositoryImpl implements EmotionRepository {
  @override
  Future<Result<void, CreateEmotionIssue>> createEmotionRecord(
      {required Date date, required EmotionEnum emotion, required String text}) async {
    return Success(null);
  }

  @override
  Future<Result<List<DayRecord>, DefaultIssue>> getEmotionRecords(
      {required int year, required int month}) async {
    return Success([]);
  }
}

class MockEmotionRepositoryImplFactory implements EmotionRepositoryFactory {
  @override
  EmotionRepository createEmotionRepository() {
    return MockEmotionRepositoryImpl();
  }
}
