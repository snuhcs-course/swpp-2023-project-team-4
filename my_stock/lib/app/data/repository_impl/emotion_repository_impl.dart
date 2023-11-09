import 'package:dio/dio.dart';
import 'package:my_stock/app/data/util/http_util.dart';
import 'package:my_stock/app/domain/model/emotion.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/core/util/date.dart';

class EmotionRepositoryImpl implements EmotionRepository {
  final HttpUtil _httpUtil = HttpUtil.I;

  @override
  Future<Result<void, CreateEmotionIssue>> createEmotionRecord({
    required Date date,
    required EmotionEnum emotion,
    required String text,
  }) async {
    try {
      final response =
          await _httpUtil.put("/api/emotions/${date.year}/${date.month}/${date.day}/", data: {
        "emotion": emotion.toInt,
        "text": text,
      });
      return Success(null);
    } on DioException catch (e) {
      if (e.response?.statusCode == 405) {
        return Fail(CreateEmotionIssue.beforeThisWeek);
      }
      return Fail(CreateEmotionIssue.unknown);
    }
  }
}
