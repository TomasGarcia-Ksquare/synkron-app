import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/text/two_column_text.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/circular_progress_bar.dart';

class TimeOffBalanceCard extends StatelessWidget {
  final EmployeeTimeOffModel timeoff;
  const TimeOffBalanceCard({super.key, required this.timeoff});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: ColorsTheme.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: ColorsTheme.primaryBlue, width: 2.0)),
      child: Column(
        children: <Widget>[
          Container(
            height: 48.0,
            decoration: const BoxDecoration(
                color: ColorsTheme.accentBlue1,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(22.0))),
            child: Row(
              children: [
                const SizedBox(width: 8.0),
                SvgPicture.asset("assets/icons/${timeoff.iconName}.svg",
                    height: 24, width: 24),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(timeoff.displayName!,
                      style: TypographyTheme.fontSubH2AccentBlue2),
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
                        style1: TypographyTheme.fontSub1PrimaryBlue,
                        style2: TypographyTheme.fontCapPrimaryBlue)
                    : TwoColumnText(
                        data1: "${timeoff.temporalRemainder! ~/ 8} days",
                        data2: "available",
                        style1: TypographyTheme.fontSub1PrimaryBlue,
                        style2: TypographyTheme.fontCapPrimaryBlue),
                percent: 1 -
                    (timeoff.temporalRemainder!.toDouble() /
                        timeoff.grantedHours!.toDouble())),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.circle,
                    size: 10.0,
                    color: ColorsTheme.primaryBlue,
                  ),
                  SizedBox(height: 8.0),
                  Icon(
                    Icons.circle,
                    size: 10.0,
                    color: ColorsTheme.accentBlue2,
                  ),
                ],
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${timeoff.takenHours} taken",
                      style: TypographyTheme.fontBody3),
                  Text("${timeoff.requestedHours} requested",
                      style: TypographyTheme.fontBody3)
                ],
              )
            ],
          ),
          const SizedBox(height: 8.0),
          Text("Total granted", style: TypographyTheme.fontCapAccentBlue2),
          timeoff.timeUnit == "hrs"
              ? Text(
                  "${timeoff.grantedHours} hrs (or ${timeoff.grantedHours! ~/ 8} workdays)",
                  style: TypographyTheme.fontBody3AccentBlue2)
              : Text("${timeoff.grantedHours! ~/ 8} workdays",
                  style: TypographyTheme.fontBody3AccentBlue2),
          if (timeoff.renewalDate != null)
            Text("due ${timeoff.renewalDate}",
                style: TypographyTheme.fontBody3),
        ],
      ),
    );
  }
}
