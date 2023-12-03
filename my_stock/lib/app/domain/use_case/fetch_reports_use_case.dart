import 'package:my_stock/app/domain/model/report.dart';
import 'package:my_stock/app/domain/repository_interface/report_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class FetchReportsUseCase {
  final ReportRepository _reportRepository;

  FetchReportsUseCase({required ReportRepository reportRepository})
      : _reportRepository = reportRepository;

  Future<void> call({
    required void Function(List<Report>) onSuccess,
  }) async {
    final result = await _reportRepository.getReports();

    switch (result) {
      case Success(:final data):
        onSuccess(data);
      case Fail(:final issue):
        return;
    }
  }
}
