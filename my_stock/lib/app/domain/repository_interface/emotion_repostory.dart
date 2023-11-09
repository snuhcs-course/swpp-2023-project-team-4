import 'package:my_stock/app/domain/model/emotion.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/core/util/date.dart';

abstract class EmotionRepository {
  Future<Result<void, CreateEmotionIssue>> createEmotionRecord({
    required Date date,
    required EmotionEnum emotion,
    required String text,
  });
}

enum CreateEmotionIssue {
  beforeThisWeek,
}
