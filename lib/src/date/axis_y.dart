import 'package:flutter/material.dart';

class AxisYWidget extends StatelessWidget {
  const AxisYWidget({
    Key? key,
    required this.maxValue,
    required this.displayXAxis,
  }) : super(key: key);

  final int maxValue;
  final bool displayXAxis;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
