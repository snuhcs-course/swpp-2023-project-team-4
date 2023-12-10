import 'package:my_stock/app/domain/model/emotion_return_rate.dart';
import 'package:my_stock/app/domain/model/report.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/core/util/date.dart';

abstract class ReportRepository {
  Future<Result<List<Report>, DefaultIssue>> getReports();

  Future<Result<List<EmotionReturnRate>, DefaultIssue>> getEmotionReturnRates({
    required Date startDate,
    required Date endDate,
  });
}

abstract class ReportRepositoryFactory {
  ReportRepository createReportRepository();
}
