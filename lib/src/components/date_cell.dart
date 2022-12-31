import 'package:flutter/material.dart';

class DateCell extends StatelessWidget {
  const DateCell({
    required this.blocWidth,
    Key? key,
    required this.keys,
    required this.value,
  }) : super(key: key);

  final double blocWidth;
  final double value;
  final List<DateTime> keys;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: blocWidth > 24 ? 2 : 0,
      ),
      child: Container(
        color: keys.isEmpty ? Colors.transparent : primaryColor,
        height: keys.isEmpty ? 0 : value,
        width: blocWidth > 24 ? blocWidth - 4 : blocWidth,
      ),
    );
  }
}
