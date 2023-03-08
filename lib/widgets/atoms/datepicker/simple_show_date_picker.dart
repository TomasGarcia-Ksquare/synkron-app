import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';

simpleShowDatePicker(context,
    {initialDate, firstDate, lastDate, primaryColor}) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
                primary: primaryColor ?? ColorsTheme.primaryBlue)),
        child: child!,
      );
    },
  );
}
