import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';

class MenuOptionWidget extends StatelessWidget {
  String text;

  MenuOptionWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        style: TypographyTheme.fontH5PrimaryBlue,
        textAlign: TextAlign.center,
      ),
    );
  }
}
