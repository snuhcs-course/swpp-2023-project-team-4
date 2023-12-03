import 'package:my_stock/app/domain/model/emotion_return_rate.dart';
import 'package:my_stock/app/domain/model/report.dart';
import 'package:my_stock/app/domain/result.dart';

abstract class ReportRepository {
  Future<Result<List<Report>, DefaultIssue>> getReports();

  Future<Result<List<EmotionReturnRate>, DefaultIssue>> getEmotionReturnRates();
}

abstract class ReportRepositoryFactory {
  ReportRepository createReportRepository();
}
