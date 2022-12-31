import 'package:flutter/material.dart';

import 'axis_x.dart';
import 'axis_y.dart';
import 'cells_list.dart';
import 'data_provider.dart';

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
    return DataProvider(
      data: data,
      builder: (context, keys, values, displayMode, maxValue, total, minDate) {
        return Material(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (displayYAxis)
                        AxisYWidget(
                          maxValue: maxValue,
                          displayXAxis: displayXAxis,
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
                              child: CellsList(
                                length: total,
                                displayMode: displayMode,
                                keys: keys,
                                values: values,
                                minDate: minDate!,
                              ),
                            ),
                            Container(
                              color: Colors.black,
                              height: thickness,
                            ),
                            if (displayXAxis) AxisXWidget(keys: keys)
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
      },
    );
  }
}
