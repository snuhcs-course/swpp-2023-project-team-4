import 'package:dio/dio.dart';
import 'package:my_stock/app/data/dto/day_record_dto.dart';
import 'package:my_stock/app/data/util/http_util.dart';
import 'package:my_stock/app/domain/model/day_record.dart';
import 'package:my_stock/app/domain/model/emotion.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/core/constants/emotion.dart';
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

  @override
  Future<Result<List<DayRecord>, DefaultIssue>> getEmotionRecords(
      {required int year, required int month}) async {
    try {
      final response = await _httpUtil.get("/api/emotions/$year/$month/");
      List emotionJsonList = response.data["emotions"];
      List<DayRecordDTO> dtos = [];
      for (var json in emotionJsonList) {
        dtos.add(DayRecordDTO.fromJson(json));
      }
      List<DayRecord> dayRecords = [];
      for (var dto in dtos) {
        Emotion emotion;
        if (dto.emotion == -2) {
          emotion = Emotion.sadder;
        } else if (dto.emotion == -1) {
          emotion = Emotion.sad;
        } else if (dto.emotion == 0) {
          emotion = Emotion.neutral;
        } else if (dto.emotion == 1) {
          emotion = Emotion.happy;
        } else {
          emotion = Emotion.happier;
        }
        dayRecords.add(
          DayRecord(
              date: Date(
                year: year,
                month: month,
                day: dto.date,
              ),
              emotion: emotion,
              text: dto.text),
        );
      }
      return Success(dayRecords);
    } on DioException catch (e) {
      return Fail(DefaultIssue.badRequest);
    }
  }
}

class EmotionRepositoryFactoryImpl implements EmotionRepositoryFactory {
  @override
  EmotionRepository createEmotionRepository() {
    return EmotionRepositoryImpl();
  }
}
