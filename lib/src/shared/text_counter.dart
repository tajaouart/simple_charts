import 'package:flutter/material.dart';

/// Gives border effect for text
class TextCounter extends StatelessWidget {
  const TextCounter(this.value, {Key? key}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          //keys[index],
          maxLines: 1,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
