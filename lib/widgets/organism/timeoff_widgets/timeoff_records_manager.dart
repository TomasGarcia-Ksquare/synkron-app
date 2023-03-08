import 'package:flutter/material.dart';
import 'package:synkron_app/extensions/camel_case_extension.dart';

import '../../../models/time_off/manager/myteam_timeoff_requests_model.dart';
import '../../../providers/manager/time_off/myteam_timeoff_request_provider.dart';
import '../../../styles/font_styles.dart';
import '../../atoms/divider/horizontal_divider_widget.dart';
import '../../atoms/painter/status_container.dart';
import '../../molecules/approval_row/approval_row_buttons.dart';

class TimeOffRecordsMyTeam extends StatelessWidget {
  final TimeOffRequestsModel myTeam;
  final TimeOffRequestsMyTeamProvider myTeamProvider;

  const TimeOffRecordsMyTeam({
    super.key,
    required this.myTeam,
    required this.myTeamProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: myTeam.state == "requested"
            ? Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusContainer(key: key, text: myTeam.state.capitalize()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          myTeam.benefit.displayName,
                          style: TypographyTheme.fontSub1,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          myTeam.employee.fullName,
                          style: TypographyTheme.fontSub1,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 74.0,
                              child: Text(
                                'Requested',
                                style: TypographyTheme.fontSubH2,
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: Text(
                                getHoursPerDay(myTeam.hoursPerDayList),
                                style: TypographyTheme.fontBody2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 70.0,
                              child: Text(
                                'Start Date',
                                style: TypographyTheme.fontSubH2,
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: Text(
                                myTeam.startDate,
                                style: TypographyTheme.fontBody2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 70.0,
                              child: Text(
                                'End Date',
                                style: TypographyTheme.fontSubH2,
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: Text(
                                myTeam.endDate,
                                style: TypographyTheme.fontBody2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const HorizontalDividerWidget(),
                        ApprovalRowButtons(
                            timeOffMyTeam: myTeam,
                            myTeamProvider: myTeamProvider),
                      ],
                    ),
                  ],
                ))
            : Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusContainer(key: key, text: myTeam.state.capitalize()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          myTeam.benefit.displayName,
                          style: TypographyTheme.fontSub1,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          myTeam.employee.fullName,
                          style: TypographyTheme.fontSub1,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 74.0,
                              child: Text(
                                'Requested',
                                style: TypographyTheme.fontSubH2,
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: Text(
                                getHoursPerDay(myTeam
                                    .hoursPerDayList), //hay que hacer una suma aqui
                                style: TypographyTheme.fontBody2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 70.0,
                              child: Text(
                                'Start Date',
                                style: TypographyTheme.fontSubH2,
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: Text(
                                myTeam.startDate,
                                style: TypographyTheme.fontBody2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 70.0,
                              child: Text(
                                'End Date',
                                style: TypographyTheme.fontSubH2,
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: Text(
                                myTeam.endDate,
                                style: TypographyTheme.fontBody2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )));
  }

  String getHoursPerDay(List<HoursPerDayListModel> hoursPerDayLista) {
    int totalHours =
        hoursPerDayLista.map((e) => e.hours).reduce((a, b) => a + b);
    if (totalHours > 8) {
      return '${(totalHours / 8).toString().replaceAll('.0', '')} days ';
    } else if (totalHours == 8) {
      return '${(totalHours / 8).toString().replaceAll('.0', '')} day ';
    } else {
      return '$totalHours hrs ';
    }
  }
}
