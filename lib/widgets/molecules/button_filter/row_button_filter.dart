import 'package:flutter/material.dart';

import '../../../styles/colors_theme.dart';
import '../../atoms/button/custom_filter_button.dart';
//import '../../atoms/dropdown/dropdown_button.dart';

class RowButtonFilter extends StatelessWidget {
  RowButtonFilter({
    Key? key,
    required this.onPressedFilterAlt,
    required this.onPressedSort,
    required this.onPressedToday,
    required this.conditionalWidget,
  }) : super(key: key);
  final dynamic onPressedFilterAlt;
  final dynamic onPressedSort;
  final dynamic onPressedToday;
  final Widget conditionalWidget;

  //List<String> list = <String>['Future Request', 'Past Request'];
  //String dropdownValue = 'Future Request';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomFilterButton(
          key: key,
          icon: Icons.filter_alt,
          onPressed: onPressedFilterAlt,
          iconSize: 24.0,
          color: Colors.black,
          focusColor: ColorsTheme.accentBlue2,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        ),
        CustomFilterButton(
          key: key,
          icon: Icons.today,
          onPressed: onPressedToday,
          iconSize: 24.0,
          color: Colors.black,
          focusColor: ColorsTheme.accentBlue2,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        ),
        conditionalWidget,
        CustomFilterButton(
          key: key,
          icon: Icons.sort,
          onPressed: onPressedSort,
          iconSize: 24.0,
          color: Colors.black,
          focusColor: ColorsTheme.accentBlue2,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        )
      ],
    );
  }
}

class RowButtonExpandedFilter extends StatelessWidget {
  RowButtonExpandedFilter(
      {Key? key,
      required this.onPressedFilterAlt,
      required this.onPressedSort,
      required this.onPressedToday,
      required this.conditionalWidget,
      required this.text,
      required this.style})
      : super(key: key);
  final dynamic onPressedFilterAlt;
  final dynamic onPressedSort;
  final dynamic onPressedToday;
  final Widget conditionalWidget;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            text,
            style: style,
          ),
        ),
        CustomFilterButton(
          key: key,
          icon: Icons.filter_alt,
          onPressed: onPressedFilterAlt,
          iconSize: 24.0,
          color: ColorsTheme.primaryBlue,
          focusColor: ColorsTheme.accentBlue2,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        ),
        CustomFilterButton(
          key: key,
          icon: Icons.today,
          onPressed: onPressedToday,
          iconSize: 24.0,
          color: ColorsTheme.primaryBlue,
          focusColor: ColorsTheme.accentBlue2,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        ),
        conditionalWidget,
        CustomFilterButton(
          key: key,
          icon: Icons.sort,
          onPressed: onPressedSort,
          iconSize: 24.0,
          color: ColorsTheme.primaryBlue,
          focusColor: ColorsTheme.accentBlue2,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        )
      ],
    );
  }
}

class SizedIconButton extends StatelessWidget {
  SizedIconButton({Key? key, required this.onPressed, required this.width})
      : super(key: key);
  final dynamic onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: CustomFilterButton(
          key: key,
          icon: Icons.close,
          onPressed: onPressed,
          iconSize: 24.0,
          color: ColorsTheme.primaryBlue,
          focusColor: ColorsTheme.accentBlue2,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        ));
  }
}
