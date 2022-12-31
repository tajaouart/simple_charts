import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../utils/extensions.dart';
import 'date_cell.dart';

class CellsList extends StatelessWidget {
  const CellsList({
    Key? key,
    required this.length,
    required this.displayMode,
    required this.keys,
    required this.values,
    required this.minDate,
  }) : super(key: key);

  final ChartDateDisplay displayMode;
  final List<DateTime> keys;
  final List<int> values;
  final int length;
  final DateTime minDate;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.isEmpty ? 0 : values.max;
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        final num maxWidth;
        if (constraints.maxWidth.toString() == 'NaN') {
          maxWidth = 0;
        } else {
          maxWidth = constraints.maxWidth;
        }
        final blocWidth = (maxWidth / length);
        var dataIndex = 0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(length, (index) {
            final keysList = keys.where((element) {
              switch (displayMode) {
                case ChartDateDisplay.day:
                  return keys[dataIndex].sameDay(
                    minDate.add(Duration(days: index)),
                  );
                case ChartDateDisplay.month:
                  return keys[dataIndex].sameMonth(
                    DateTime(
                      minDate.year,
                      minDate.month + index,
                    ),
                  );
                case ChartDateDisplay.year:
                  return keys[dataIndex].sameYear(
                    DateTime(
                      minDate.year + index,
                    ),
                  );
              }
            }).toList();
            final num maxHeight;
            if (constraints.maxHeight.toString() == 'NaN') {
              maxHeight = 0;
            } else {
              maxHeight = constraints.maxHeight;
            }
            var value = displayMode == ChartDateDisplay.day
                ? (values.elementAt(dataIndex).toDouble() * maxHeight) /
                    (maxValue == 0 ? 1 : maxValue)
                : (values.elementAt(dataIndex).toDouble() * maxHeight) /
                    (maxValue == 0 ? 1 : maxValue);

            if (keysList.isNotEmpty) {
              dataIndex++;
            }

            return DateCell(
              keys: keysList,
              value: value,
              blocWidth: blocWidth,
            );
          }),
        );
      },
    );
  }
}
