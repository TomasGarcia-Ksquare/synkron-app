import 'package:flutter/material.dart';

class TwoColumnText extends StatelessWidget {
  final String data1;
  final String data2;
  final TextStyle style1;
  final TextStyle style2;
  const TwoColumnText(
      {super.key,
      required this.data1,
      required this.data2,
      required this.style1,
      required this.style2});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(data1, style: style1),
        Text(data2, style: style2),
        const SizedBox(height: 2.0)
      ],
    );
  }
}
