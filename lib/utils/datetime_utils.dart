
extension DateTimeExtension on DateTime{
  static String getCurrentDate(){
    return DateTime.now().toString();
  }
}

extension intMonthExtension on int {
  String intMonthToString(){
    return this < 10 ? "0$this" : "$this";
  }
}

int getCurrentYear() {
  return DateTime.now().year;
}
int getCurrentMonth() {
  return DateTime.now().month;
}
int getCurrentDay() {
  return DateTime.now().day;
}


final List<int> _daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    if (isLeapYear) return 29;
    return 28;
  }
  return _daysInMonth[month-1];
}
