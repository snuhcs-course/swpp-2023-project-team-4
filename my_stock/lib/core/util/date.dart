import 'package:equatable/equatable.dart';

class Date extends Equatable {
  final int year;
  final int month;
  final int day;

  const Date({
    required this.year,
    required this.month,
    required this.day,
  });

  factory Date.fromDateTime(DateTime dateTime) {
    return Date(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
  }

  bool operator >(covariant Date other) {
    if (this.year == other.year) {
      if (this.month == other.month) {
        if (this.day > other.day) {
          return true;
        }
        return false;
      }
      return this.month > other.month;
    }
    return this.year > other.year;
  }

  @override
  List<Object?> get props => [year, month, day];

  DateTime toDateTime() {
    return DateTime(year, month, day);
  }

  factory Date.now() {
    return Date.fromDateTime(DateTime.now());
  }
}

extension DateExtension on Date {
  String get dayOfWeek {
    final dayOfWeek = DateTime(year, month, day).weekday;
    switch (dayOfWeek) {
      case DateTime.monday:
        return "월";
      case DateTime.tuesday:
        return "화";
      case DateTime.wednesday:
        return "수";
      case DateTime.thursday:
        return "목";
      case DateTime.friday:
        return "금";
      case DateTime.saturday:
        return "토";
      case DateTime.sunday:
        return "일";
      default:
        return "";
    }
  }

  bool isSameWeek(Date other) {
    DateTime datetime1 = this.toDateTime();
    DateTime datetime2 = other.toDateTime();
    int weekday1 = datetime1.weekday;
    int weekday2 = datetime2.weekday;
    return datetime1.subtract(Duration(days: weekday1)) ==
        datetime2.subtract(Duration(days: weekday2));
  }

  int get weekday {
    return DateTime(year, month, day).weekday;
  }

  Date subtract(Duration duration) {
    return Date.fromDateTime(this.toDateTime().subtract(duration));
  }

  Date add(Duration duration) {
    return Date.fromDateTime(this.toDateTime().add(duration));
  }

  (int, int, int) get nthWeek {
    int year = this.year;
    int weekday = this.weekday;
    Date thirsday = this.add(Duration(days: 4 - weekday));
    int thirsdayMonth = thirsday.month;

    int prevCount = 0;

    Date prevDate = thirsday.subtract(Duration(days: 7));
    while (prevDate.month == thirsdayMonth) {
      prevCount++;
      prevDate = prevDate.subtract(Duration(days: 7));
    }

    return (year, thirsdayMonth, prevCount + 1);
  }

  Date get firstDayOfWeek {
    int weekday = this.weekday;
    return this.subtract(Duration(days: weekday - 1));
  }

  Date get lastDayOfWeek {
    int weekday = this.weekday;
    return this.add(Duration(days: 7 - weekday));
  }
}
