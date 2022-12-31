import 'dart:math';

import 'package:flutter/material.dart';

import '../shared/text_counter.dart';

class CellsList extends StatelessWidget {
  const CellsList({
    Key? key,
    required this.cellWidth,
    required this.length,
    required this.totalValues,
    required this.values,
    required this.keys,
    required this.otherStr,
  }) : super(key: key);

  final List<String> keys;
  final double cellWidth;
  final List<int> values;
  final int totalValues;
  final int length;
  final String otherStr;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [];
    final primaryColor = Theme.of(context).colorScheme.primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final num maxWidth;
        if (constraints.maxWidth.toString() == 'NaN') {
          maxWidth = 0;
        } else {
          maxWidth = constraints.maxWidth;
        }
        final cellWidth = (maxWidth / length);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
            length,
            (index) {
              final num maxHeight;
              if (constraints.maxHeight.toString() == 'NaN') {
                maxHeight = 0;
              } else {
                maxHeight = constraints.maxHeight;
              }
              var value = totalValues == 0
                  ? 1.0
                  : ((100 * values[index]) ~/ totalValues).toDouble() /
                      100 *
                      maxHeight;

              colors.add(
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
              );

              return Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: double.infinity,
                      width: cellWidth - 2,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey.withAlpha(50),
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
                        width: cellWidth - 2,
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: -1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4.0,
                            ),
                            child: TextCounter(
                                keys[index].isEmpty ? otherStr : keys[index]),
                          ),
                          TextCounter(
                            (values[index] == 0
                                        ? 0.toString()
                                        : (100 * values[index]) ~/ totalValues)
                                    .toString() +
                                ('%'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
