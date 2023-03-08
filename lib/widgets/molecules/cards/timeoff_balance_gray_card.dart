import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/text/two_column_text.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/circular_progress_bar.dart';

class TimeOffBalanceGrayCard extends StatelessWidget {
  final EmployeeTimeOffModel timeoff;
  const TimeOffBalanceGrayCard({super.key, required this.timeoff});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: ColorsShadesTheme.neutralGray1,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(
              color: ColorsShadesTheme.disabledGray2, width: 2.0)),
      child: Column(
        children: <Widget>[
          Container(
            height: 48.0,
            decoration: const BoxDecoration(
                color: ColorsShadesTheme.disabledGray2,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(22.0))),
            child: Row(
              children: [
                const SizedBox(width: 8.0),
                SvgPicture.asset(
                  "assets/icons/${timeoff.iconName}.svg",
                  height: 24,
                  width: 24,
                  color: ColorsTheme.white,
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    timeoff.displayName!,
                    style: TypographyTheme.fontSubH2White,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: CircularProgressBar(
              radius: 48.0,
              lineWidth: 8.0,
              center: timeoff.timeUnit == "hrs"
                  ? TwoColumnText(
                      data1: "${timeoff.temporalRemainder} hrs",
                      data2: "available",
                      style1: TypographyTheme.fontSub1DisableGray2,
                      style2: TypographyTheme.fontCapDisableGray2)
                  : TwoColumnText(
                      data1: "${timeoff.temporalRemainder! ~/ 8} days",
                      data2: "available",
                      style1: TypographyTheme.fontSub1DisableGray2,
                      style2: TypographyTheme.fontCapDisableGray2),
              percent: 0,
              backgroundColor: ColorsShadesTheme.disabledGray2,
              progressColor: ColorsShadesTheme.disabledGray2,
            ),
          ),
          const SizedBox(height: 46.0),
          Text("Total granted", style: TypographyTheme.fontCapDisableGray2),
          timeoff.timeUnit == "hrs"
              ? Text(
                  "${timeoff.grantedHours} hrs (or ${timeoff.grantedHours! ~/ 8} workdays)",
                  style: TypographyTheme.fontBody3DisableGray2)
              : Text("${timeoff.grantedHours! ~/ 8} workdays",
                  style: TypographyTheme.fontBody3DisableGray2),
          if (timeoff.renewalDate != null)
            Text("until ${timeoff.renewalDate}",
                style: TypographyTheme.fontBody3DisableGray2),
        ],
      ),
    );
  }
}
