import 'package:my_stock/app/domain/model/emotion_return_rate.dart';
import 'package:my_stock/app/domain/repository_interface/report_repository.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/core/util/date.dart';

class FetchEmotionReturnRateUseCase {
  final ReportRepository _reportRepository;

  const FetchEmotionReturnRateUseCase({
    required ReportRepository reportRepository,
  }) : _reportRepository = reportRepository;

  Future<void> call({
    required Date startDate,
    required Date endDate,
    required void Function(List<EmotionReturnRate>) onSuccess,
  }) async {
    final result = await _reportRepository.getEmotionReturnRates(
      startDate: startDate,
      endDate: endDate,
    );

    switch (result) {
      case Success(:final data):
        onSuccess(data);
      case Fail(:final issue):
        return;
    }
  }
}
