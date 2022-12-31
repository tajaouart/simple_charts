import 'package:flutter/material.dart';

import '../utils/extensions.dart';
import 'methods.dart';

class AxisXWidget extends StatelessWidget {
  const AxisXWidget({
    Key? key,
    required this.keys,
  }) : super(key: key);

  final List<DateTime> keys;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                seconds: (max!.difference(min).inSeconds ~/ 2),
              ),
            );
            return Text(getDateString(mid));
          } else {
            final max = calcMaxDate(keys);
            return Text(getDateString(max!));
          }
        }),
      ),
    );
  }
}
