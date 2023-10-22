import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/core/util/date.dart';

class DateEmotionVM {
  final Date? date;
  final EmotionVMEnum? emotion;

  DateEmotionVM({
    this.date,
    this.emotion,
  }) : assert((date == null && emotion == null) || (date != null && emotion != null));
}