class YearMonth {
  final int year;
  final int month;

  const YearMonth({
    required this.year,
    required this.month,
  });

  factory YearMonth.fromDateTime(DateTime dateTime) {
    return YearMonth(
      year: dateTime.year,
      month: dateTime.month,
    );
  }
}
