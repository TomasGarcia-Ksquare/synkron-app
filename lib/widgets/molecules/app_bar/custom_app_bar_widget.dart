import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

AppBar customAppBar(
    {double elevation = 0.0,
    String title = '',
    TextStyle textStyle = TypographyTheme.fontH4,
    Color backgroundColor = ColorsTheme.accentBlue1}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: elevation,
    title: Text(
      title,
      style: textStyle,
    ),
    iconTheme: const IconThemeData(color: ColorsTheme.primaryBlue),
  );
}
