import 'package:my_stock/app/domain/model/day_record.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/result.dart';

class FetchMonthRecordsUseCase {
  final EmotionRepository _emotionRepository;

  const FetchMonthRecordsUseCase({
    required EmotionRepository emotionRepository,
  }) : _emotionRepository = emotionRepository;

  Future<void> call({
    required int year,
    required int month,
    required void Function(List<DayRecord>) onSuccess,
  }) async {
    final result = await _emotionRepository.getEmotionRecords(year: year, month: month);
    if (result is Fail) {
      return;
    }
    onSuccess((result as Success).data);
  }
}
