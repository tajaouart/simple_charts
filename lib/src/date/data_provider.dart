import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../utils/extensions.dart';
import 'methods.dart';

/// Wrapper handles data to provide the result in a clean way
class DataProvider extends StatelessWidget {
  const DataProvider({
    Key? key,
    required this.data,
    required this.builder,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    List<DateTime> keys,
    List<int> values,
    ChartDateDisplay displayMode,
    int maxValue,
    int total,
    DateTime? minDate,
  ) builder;

  final Map<DateTime, int> data;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> keys = data.keys.toList();
    final List<int> values = [];
    final maxDate = calcMaxDate(keys);
    final minDate = calcMinDate(keys);

    var displayMode = ChartDateDisplay.day;
    late final int total;

    final totalDays = maxDate == null || minDate == null
        ? 0
        : maxDate.difference(minDate).inDays;

    if (totalDays == 0) {
      total = 0;
    } else if (totalDays < 60) {
      total = totalDays + 1;
      displayMode = ChartDateDisplay.day;
      values.addAll(data.values.toList());
    } else if (totalDays < 367) {
      displayMode = ChartDateDisplay.month;
      final monthValue = <DateTime, int>{};
      for (var element in keys) {
        monthValue.putIfAbsent(DateTime(element.year, element.month), () => 0);
      }

      for (var element in keys) {
        monthValue.update(DateTime(element.year, element.month), (value) {
          return value + (data[element] ?? 0);
        });
      }

      values.addAll(monthValue.values.toList());
      keys.clear();
      keys.addAll(monthValue.keys.toList());
      total = keys.length;
    } else {
      displayMode = ChartDateDisplay.year;
      final yearValue = <DateTime, int>{};
      for (var e in keys) {
        yearValue.putIfAbsent(
          DateTime(
            e.year,
          ),
          () => 0,
        );
      }

      for (var element in keys) {
        yearValue.update(
            DateTime(
              element.year,
            ), (value) {
          return value + (data[element] ?? 0);
        });
      }

      values.addAll(yearValue.values.toList());
      keys.clear();
      keys.addAll(yearValue.keys.toList());
      total = keys.length;
    }
    final maxValue = values.isEmpty ? 0 : values.max;

    return builder(
      context,
      keys,
      values,
      displayMode,
      maxValue,
      total,
      minDate,
    );
  }
}
