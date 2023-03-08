import 'package:flutter/material.dart';

class BulletText extends StatelessWidget {
  final String data;
  final double bulletSize;
  final Color bulletColor;
  final TextStyle textStyle;
  const BulletText(
      {super.key,
      required this.data,
      required this.bulletColor,
      required this.textStyle,
      required this.bulletSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.circle,
          size: bulletSize,
          color: bulletColor,
        ),
        const SizedBox(width: 8.0),
        Text(data, style: textStyle),
      ],
    );
  }
}
