import 'package:my_stock/app/domain/model/day_record.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:my_stock/core/util/date.dart';

class FetchEmotionRecordsUseCase {
  final EmotionRepository _emotionRepository;

  FetchEmotionRecordsUseCase(this._emotionRepository);

  Future<void> call({
    required Date startDate,
    required Date endDate,
    required void Function(List<DayRecord>) onSuccess,
  }) async {
    final result = await _emotionRepository.getEmotionRecordsByDateRange(
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
