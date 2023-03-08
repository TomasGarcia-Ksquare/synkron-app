import 'package:flutter/material.dart';
import 'package:synkron_app/extensions/camel_case_extension.dart';

import '../../../models/time_off/employee/employee_timeoff_records_model.dart';
import '../../../styles/font_styles.dart';
import '../../atoms/painter/status_container.dart';

class TimeOffRecordsEmployee extends StatelessWidget {
  final TimeOffEmployeeRecordsModel employee;

  const TimeOffRecordsEmployee({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusContainer(key: key, text: employee.state.capitalize()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      employee.benefit.displayName,
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
                            getHoursPerDay(employee.hoursPerDayList),
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
                            employee.startDate,
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
                            employee.endDate,
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
