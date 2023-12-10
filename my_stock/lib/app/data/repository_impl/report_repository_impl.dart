import 'package:dio/dio.dart';
import 'package:my_stock/app/data/dto/emotion_return_dto.dart';
import 'package:my_stock/app/data/dto/report_dto.dart';
import 'package:my_stock/app/data/util/http_util.dart';
import 'package:my_stock/app/domain/model/emotion_return_rate.dart';
import 'package:my_stock/app/domain/model/report.dart';
import 'package:my_stock/app/domain/repository_interface/report_repository.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/core/constants/emotion.dart';
import 'package:my_stock/core/util/date.dart';

class ReportRepositoryImpl implements ReportRepository {
  final HttpUtil _httpUtil = HttpUtil.I;

  @override
  Future<Result<List<Report>, DefaultIssue>> getReports() async {
    try {
      final response = await _httpUtil.get('/report/');
      final dtos = (response.data as List)
          .map((e) => ReportDTO.fromJson(e as Map<String, dynamic>))
          .toList();
      List<Report> reports = [];
      for (ReportDTO reportDTO in dtos) {
        reports.add(Report(title: reportDTO.title, body: reportDTO.body));
      }
      return Success(reports);
    } on DioException catch (e) {
      return Fail(DefaultIssue.badRequest);
    }
  }

  @override
  Future<Result<List<EmotionReturnRate>, DefaultIssue>> getEmotionReturnRates({
    required Date startDate,
    required Date endDate,
  }) async {
    try {
      final response = await _httpUtil.get(
        "/balance/return_rate",
        queryParameters: {
          "sdate": startDate.toDashString,
          "edate": endDate.toDashString,
        },
      );
      final dtos = (response.data as List)
          .map((e) => EmotionReturnDTO.fromJson(e as Map<String, dynamic>))
          .toList();
      List<EmotionReturnRate> emotionReturnRates = [];

      for (var dto in dtos) {
        Emotion emotion;
        if (dto.emotion == 2) {
          emotion = Emotion.happier;
        } else if (dto.emotion == 1) {
          emotion = Emotion.happy;
        } else if (dto.emotion == 0) {
          emotion = Emotion.neutral;
        } else if (dto.emotion == -1) {
          emotion = Emotion.sad;
        } else if (dto.emotion == -2) {
          emotion = Emotion.sadder;
        } else {
          throw Exception();
        }
        emotionReturnRates.add(
          EmotionReturnRate(
            emotion: emotion,
            returnRate: dto.returnRate,
          ),
        );
      }
      return Success(emotionReturnRates);
    } on DioException {
      return Fail(DefaultIssue.badRequest);
    }
  }
}

class ReportRepositoryFactoryImpl implements ReportRepositoryFactory {
  @override
  ReportRepository createReportRepository() {
    return ReportRepositoryImpl();
  }
}
