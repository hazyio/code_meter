class DateTimeDiffData {
  final int seconds;
  final int minutes;
  final int hours;
  final int days;
  final int weeks;
  final int months;
  final int years;

  DateTimeDiffData._({
    required this.seconds,
    required this.minutes,
    required this.hours,
    required this.days,
    required this.weeks,
    required this.months,
    required this.years,
  });

  factory DateTimeDiffData.from(String dateTime) {
    final now = DateTime.now();
    final past = DateTime.parse(dateTime);
    final diff = now.difference(past);

    return DateTimeDiffData._(
      seconds: diff.inSeconds,
      minutes: diff.inMinutes,
      hours: diff.inHours,
      days: diff.inDays,
      weeks: (diff.inDays / 7).floor(),
      months: _monthsBetween(past, now),
      years: _yearsBetween(past, now),
    );
  }

  static int _monthsBetween(DateTime from, DateTime to) {
    return (to.year - from.year) * 12 + (to.month - from.month);
  }

  static int _yearsBetween(DateTime from, DateTime to) {
    return to.year - from.year;
  }
}
