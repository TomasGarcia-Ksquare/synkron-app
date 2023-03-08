import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:synkron_app/styles/colors_theme.dart';

class CircularProgressBar extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final double percent;
  final Widget center;
  final Color backgroundColor;
  final Color progressColor;
  const CircularProgressBar(
      {super.key,
      required this.radius,
      required this.lineWidth,
      required this.percent,
      required this.center,
      this.backgroundColor = ColorsShadesTheme.disabledGray1,
      this.progressColor = ColorsTheme.accentBlue2});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      animation: true,
      animationDuration: 1200,
      lineWidth: lineWidth,
      percent: percent,
      center: center,
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: backgroundColor,
      progressColor: progressColor,
    );
  }
}
