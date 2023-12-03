import 'package:dio/dio.dart';
import 'package:my_stock/app/data/dto/report_dto.dart';
import 'package:my_stock/app/data/util/http_util.dart';
import 'package:my_stock/app/domain/model/report.dart';
import 'package:my_stock/app/domain/repository_interface/report_repository.dart';
import 'package:my_stock/app/domain/result.dart';

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
}

class ReportRepositoryFactoryImpl implements ReportRepositoryFactory {
  @override
  ReportRepository createReportRepository() {
    return ReportRepositoryImpl();
  }
}
