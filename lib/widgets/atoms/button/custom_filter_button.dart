import 'package:flutter/material.dart';

class CustomFilterButton extends StatelessWidget {
  const CustomFilterButton(
      {Key? key,
      required this.icon,
      required this.onPressed,
      required this.iconSize,
      this.color,
      this.focusColor,
      required this.padding})
      : super(key: key);

  final IconData icon;
  final dynamic onPressed;
  final double? iconSize;
  final Color? color;
  final Color? focusColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      iconSize: iconSize,
      color: color,
      focusColor: focusColor,
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
