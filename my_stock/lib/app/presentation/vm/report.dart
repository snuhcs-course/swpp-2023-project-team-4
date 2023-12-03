import 'package:my_stock/app/domain/model/report.dart';

class ReportVM {
  final String title;
  final String body;

  ReportVM({
    required this.title,
    required this.body,
  });

  factory ReportVM.fromDomain(Report report) {
    return ReportVM(
      title: report.title,
      body: report.body,
    );
  }
}
