import 'package:flutter/material.dart';

import '../../../styles/colors_theme.dart';
import '../../../styles/font_styles.dart';

class StatusContainer extends StatelessWidget {
  StatusContainer({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: text == 'Approved' || text == 'approved'
              ? ColorsTheme.accentGreen
              : text == 'Requested' || text == 'requested'
                  ? ColorsTheme.primaryHoverBlue2
                  : text == 'Rejected' || text == 'rejected'
                      ? ColorsTheme.destructiveRed
                      : ColorsShadesTheme.disabledGray2, //Canceled
          borderRadius: BorderRadius.circular(8.0)),
      height: 24.0,
      width: 120.0,
      child: Center(
        child: Text(
          text, //Status
          textAlign: TextAlign.center,
          style: TypographyTheme.fontBody3White,
        ),
      ),
    );
  }
}
