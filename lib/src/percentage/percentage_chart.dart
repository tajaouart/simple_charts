import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'cells_list.dart';

class PercentageChart extends StatelessWidget {
  const PercentageChart({
    required this.data,
    Key? key,
    this.height = 200,
    this.otherStr = 'other',
    this.thickness = 2,
  }) : super(key: key);

  final Map<String, int> data;
  final double thickness;
  final double height;

  final String otherStr;

  @override
  Widget build(BuildContext context) {
    final List<int> values = data.values.toList();
    final List<String> keys = data.keys.toList();
    final total = keys.length;
    final totalValues = values.sum;

    return Material(
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    color: Colors.black,
                    width: thickness,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final num maxWidth;
                              if (constraints.maxWidth.toString() == 'NaN') {
                                maxWidth = 0;
                              } else {
                                maxWidth = constraints.maxWidth;
                              }
                              final cellWidth = (maxWidth / total);

                              return CellsList(
                                cellWidth: cellWidth,
                                length: total,
                                totalValues: totalValues,
                                values: values,
                                keys: keys,
                                otherStr: otherStr,
                              );
                            },
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          height: thickness,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime calcMaxDate(List<DateTime> dates) {
    DateTime maxDate = dates[0];
    for (var date in dates) {
      if (date.isAfter(maxDate)) {
        maxDate = date;
      }
    }
    return maxDate;
  }

  DateTime calcMinDate(List<DateTime> dates) {
    DateTime minDate = dates[0];
    for (var date in dates) {
      if (date.isBefore(minDate)) {
        minDate = date;
      }
    }
    return minDate;
  }
}
