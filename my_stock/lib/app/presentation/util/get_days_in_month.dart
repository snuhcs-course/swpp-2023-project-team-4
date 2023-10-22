int getDaysInMonth({required int year, required int month}) {
  DateTime firstDayOfMonth = DateTime(year, month, 1);
  DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
  return firstDayOfNextMonth.difference(firstDayOfMonth).inDays;
}