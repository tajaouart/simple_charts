extension Today on DateTime {
  bool isToday() {
    final me = DateTime(
      year,
      month,
      day,
    );

    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    return me == today;
  }

  bool sameDay(DateTime other) {
    final me = DateTime(
      year,
      month,
      day,
    );

    final otherDay = DateTime(
      other.year,
      other.month,
      other.day,
    );

    return me == otherDay;
  }

  bool sameMonth(DateTime other) {
    final me = DateTime(
      year,
      month,
    );

    final otherDay = DateTime(
      other.year,
      other.month,
    );

    return me == otherDay;
  }

  bool sameYear(DateTime other) {
    final me = DateTime(
      year,
    );

    final otherDay = DateTime(
      other.year,
    );

    return me == otherDay;
  }

  /// is After + is not same day
  bool isAfterDay(DateTime other) {
    return isAfter(other) && day != other.day;
  }

  /// is Before + is not same day
  bool isBeforeDay(DateTime other) {
    return isBefore(other) && day != other.day;
  }
}

extension StringExtension on String {
  String capitalize() {
    if (length <= 2) {
      return toUpperCase();
    }
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}


enum ChartDateDisplay { day, month, year }



String getDateString(DateTime date) {
  return '${date.day}/${date.month}';
}

