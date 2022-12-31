DateTime? calcMaxDate(List<DateTime> dates) {
  if (dates.isEmpty) {
    return null;
  }
  DateTime maxDate = dates[0];
  for (var date in dates) {
    if (date.isAfter(maxDate)) {
      maxDate = date;
    }
  }
  return maxDate;
}

DateTime? calcMinDate(List<DateTime> dates) {
  if (dates.isEmpty) {
    return null;
  }
  DateTime minDate = dates[0];
  for (var date in dates) {
    if (date.isBefore(minDate)) {
      minDate = date;
    }
  }
  return minDate;
}