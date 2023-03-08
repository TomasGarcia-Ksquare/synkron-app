import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';

class RichtextTwoStyles extends StatelessWidget {
  final String? text1;
  final TextStyle style1;
  final String? text2;
  final TextStyle style2;
  const RichtextTwoStyles(
      {super.key,
      this.text1,
      this.text2,
      required this.style1,
      required this.style2});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      style: TypographyTheme.fontBody1,
      children: <TextSpan>[
        TextSpan(text: text1, style: style1),
        TextSpan(
          text: text2,
          style: style2,
        )
      ],
    ));
  }
}
