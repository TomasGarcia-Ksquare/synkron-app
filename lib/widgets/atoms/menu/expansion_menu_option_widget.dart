import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';

class ExpansionMenuOptionWidget extends StatelessWidget {
  final String title;

  const ExpansionMenuOptionWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Text(
        title,
        style: TypographyTheme.fontH4AccentBlue2,
      ),
    );
  }
}
