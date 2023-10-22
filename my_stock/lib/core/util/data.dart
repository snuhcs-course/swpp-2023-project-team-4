class Date {
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
}