import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';

class HorizontalDividerWidget extends StatelessWidget {
  const HorizontalDividerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: ColorsShadesTheme.neutralGray2,
      thickness: 1,
    );
  }
}
