import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';

class CustomRadio extends StatelessWidget {
  final int value;
  final dynamic groupValue;
  final ValueChanged<int> onChanged;
  final Color? selected;
  final Color? unselected;
  final double? size;
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.selected,
    this.unselected,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 20,
      height: size ?? 20,
      child: Radio<int>(
          focusColor: ColorsTheme.primaryBlue,
          fillColor: MaterialStateColor.resolveWith((states) =>
              value == groupValue
                  ? (selected ?? ColorsTheme.white)
                  : (unselected ?? ColorsTheme.primaryBlue)),
          value: value,
          groupValue: groupValue,
          onChanged: (newValue) {
            onChanged(newValue!);
          }),
    );
  }
}
