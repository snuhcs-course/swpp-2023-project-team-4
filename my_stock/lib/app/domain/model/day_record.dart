import 'package:my_stock/core/constants/emotion.dart';
import 'package:my_stock/core/util/date.dart';

class DayRecord {
  final Date date;
  final Emotion emotion;
  final String text;

  DayRecord({
    required this.date,
    required this.emotion,
    required this.text,
  });
}
