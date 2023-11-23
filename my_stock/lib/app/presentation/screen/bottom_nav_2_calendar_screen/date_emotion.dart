import 'package:my_stock/app/presentation/vm/emotion_vm_enum.dart';
import 'package:my_stock/core/util/date.dart';

class DateEmotionVM {
  Date? date;
  EmotionVMEnum? emotion;
  String text;

  DateEmotionVM({
    this.date,
    this.emotion,
    this.text = "",
  });
}
