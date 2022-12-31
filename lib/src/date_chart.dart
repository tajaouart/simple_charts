import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:simple_charts/src/utils/extensions.dart';

import 'components/date_cell.dart';

class DateChart extends StatelessWidget {
  const DateChart({
    required this.data,
    this.height = 200,
    this.thickness = 2,
    this.displayYAxis = true,
    this.displayXAxis = true,
    Key? key,
  }) : super(key: key);

  final Map<DateTime, int> data;
  final double thickness;
  final double height;
  final bool displayYAxis;
  final bool displayXAxis;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> keys = data.keys.toList();
    final List<int> values = [];
    final max = calcMaxDate(keys);
    final min = calcMinDate(keys);

    var display = ChartDateDisplay.day;
    late final int total;

    final totalDays =
        max == null || min == null ? 0 : max.difference(min).inDays;

    if (totalDays == 0) {
      total = 0;
    } else if (totalDays < 60) {
      total = totalDays + 1;
      display = ChartDateDisplay.day;
      values.addAll(data.values.toList());
    } else if (totalDays < 367) {
      display = ChartDateDisplay.month;
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
      display = ChartDateDisplay.year;
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

    return Material(
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (displayYAxis)
                    Padding(
                      padding: EdgeInsets.only(bottom: displayXAxis ? 32 : 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          if (index == 0) {
                            return const Text('0');
                          } else if (index == 1) {
                            return Text(
                              maxValue == 0 ? '' : (maxValue ~/ 2).toString(),
                            );
                          } else {
                            return Text(
                              maxValue == 0 ? '' : maxValue.toString(),
                            );
                          }
                        }).reversed.toList(),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(bottom: displayXAxis ? 32 : 0),
                    color: Colors.black,
                    width: thickness,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(),
                        Expanded(
                          child: LayoutBuilder(
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
                              final blocWidth = (maxWidth / total);
                              var dataIndex = 0;

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(total, (index) {
                                  final keysList = keys.where((element) {
                                    switch (display) {
                                      case ChartDateDisplay.day:
                                        return keys[dataIndex].sameDay(
                                          min!.add(Duration(days: index)),
                                        );
                                      case ChartDateDisplay.month:
                                        return keys[dataIndex].sameMonth(
                                          DateTime(
                                            min!.year,
                                            min.month + index,
                                          ),
                                        );
                                      case ChartDateDisplay.year:
                                        return keys[dataIndex].sameYear(
                                          DateTime(
                                            min!.year + index,
                                          ),
                                        );
                                    }
                                  }).toList();
                                  final num maxHeight;
                                  if (constraints.maxHeight.toString() ==
                                      'NaN') {
                                    maxHeight = 0;
                                  } else {
                                    maxHeight = constraints.maxHeight;
                                  }
                                  var value = display == ChartDateDisplay.day
                                      ? (values
                                                  .elementAt(dataIndex)
                                                  .toDouble() *
                                              maxHeight) /
                                          (maxValue == 0 ? 1 : maxValue)
                                      : (values
                                                  .elementAt(dataIndex)
                                                  .toDouble() *
                                              maxHeight) /
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
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          height: thickness,
                        ),
                        if (displayXAxis)
                          SizedBox(
                            height: 32,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(3, (index) {
                                if (keys.isEmpty) {
                                  return const Text('');
                                }
                                if (index == 0) {
                                  return Text(getDateString(keys.first));
                                } else if (index == 1) {
                                  final max = calcMaxDate(keys);
                                  final min = calcMinDate(keys);
                                  final mid = min!.add(
                                    Duration(
                                      seconds:
                                          (max!.difference(min).inSeconds ~/ 2),
                                    ),
                                  );
                                  return Text(getDateString(mid));
                                } else {
                                  final max = calcMaxDate(keys);
                                  return Text(getDateString(max!));
                                }
                              }),
                            ),
                          )
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

  String getDateString(DateTime date) {
    return '${date.day}/${date.month}';
  }

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
}
