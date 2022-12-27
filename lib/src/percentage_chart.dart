import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

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
    final List<String> keys = data.keys.toList();
    final List<int> values = data.values.toList();
    final List<Color> colors = [];
    final total = keys.length;
    final totalValues = values.sum;

    final primaryColor = Theme.of(context).colorScheme.primary;

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

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(total, (index) {
                                  final num maxHeight;
                                  if (constraints.maxHeight.toString() ==
                                      'NaN') {
                                    maxHeight = 0;
                                  } else {
                                    maxHeight = constraints.maxHeight;
                                  }
                                  var value = totalValues == 0
                                      ? 1.0
                                      : ((100 * values[index]) ~/ totalValues)
                                              .toDouble() /
                                          100 *
                                          maxHeight;

                                  colors.add(
                                    Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                  );

                                  return Expanded(
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          height: double.infinity,
                                          width: blocWidth - 2,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                width: 1.0,
                                                color:
                                                    Colors.grey.withAlpha(50),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 1.0,
                                          ),
                                          child: Container(
                                            color: primaryColor,
                                            height: value,
                                            width: blocWidth - 2,
                                          ),
                                        ),
                                        RotatedBox(
                                          quarterTurns: -1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                  left: 4.0,
                                                ),
                                                child: Stack(
                                                  children: <Widget>[
                                                    // Stroked text as border.
                                                    Text(
                                                      keys[index].isEmpty
                                                          ? otherStr
                                                          : keys[index],
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      //keys[index],
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        foreground: Paint()
                                                          ..style =
                                                              PaintingStyle
                                                                  .stroke
                                                          ..strokeWidth = 6
                                                          ..color =
                                                              Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    // Solid text as fill.
                                                    Text(
                                                      keys[index].isEmpty
                                                          ? otherStr
                                                          : keys[index],
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      //keys[index],
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Stack(
                                                children: <Widget>[
                                                  // Stroked text as border.
                                                  Text(
                                                    (values[index] == 0
                                                                ? 0.toString()
                                                                : (100 *
                                                                        values[
                                                                            index]) ~/
                                                                    totalValues)
                                                            .toString() +
                                                        ('%'),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      foreground: Paint()
                                                        ..style =
                                                            PaintingStyle
                                                                .stroke
                                                        ..strokeWidth = 6
                                                        ..color =
                                                            Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  // Solid text as fill.
                                                  Text(
                                                    (values[index] == 0
                                                                ? 0.toString()
                                                                : (100 *
                                                                        values[
                                                                            index]) ~/
                                                                    totalValues)
                                                            .toString() +
                                                        ('%'),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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
    return '${date.day} / ${date.month}';
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
