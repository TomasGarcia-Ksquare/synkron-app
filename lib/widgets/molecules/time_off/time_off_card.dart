import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_hours_controller.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

class TimeOffCard extends StatelessWidget {
  final String displayName;
  final int value;
  final bool selected;

  // final UserTimeOffModel currentTimeoff;
  final String icon;

  final EmployeeTimeOffModel currentTimeoff;

  const TimeOffCard({
    super.key,
    required this.value,
    required this.selected,
    required this.displayName,
    required this.currentTimeoff,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    String timeDescription =
        TimeOffHoursController().textByUnits(currentTimeoff)['desc'];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 2,
          color: ColorsTheme.primaryBlue,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 152 * (96 / 152),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6), topLeft: Radius.circular(6)),
              color:
                  selected ? ColorsTheme.primaryBlue : ColorsTheme.accentBlue1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SvgPicture.asset(
                      'assets/icons/$icon.svg',
                      height: 24,
                      width: 21,
                      fit: BoxFit.fitHeight,
                      color: selected
                          ? ColorsTheme.white
                          : ColorsTheme.accentBlue2,
                    ),
                  ),

                  // Icon(
                  //   Icons.timer,
                  //   size: 21,
                  //   color:
                  //       selected ? ColorsTheme.white : ColorsTheme.accentBlue2,
                  // ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  child: Text(
                    currentTimeoff.displayName.toString(),
                    style: selected
                        ? TypographyTheme.fontBtnWhite
                        : TypographyTheme.fontBtnAccentBlue2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 152 * (52 / 152),
            width: 132,
            child: Center(
              child: Text(
                timeDescription,
                // 'Hola',
                style: TypographyTheme.fontBody3,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
