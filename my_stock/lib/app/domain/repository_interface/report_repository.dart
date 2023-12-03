import 'package:my_stock/app/domain/model/report.dart';
import 'package:my_stock/app/domain/result.dart';

abstract class ReportRepository {
  Future<Result<List<Report>, DefaultIssue>> getReports();
}

abstract class ReportRepositoryFactory {
  ReportRepository createReportRepository();
}
