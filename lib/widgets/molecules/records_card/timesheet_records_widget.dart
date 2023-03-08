import 'package:flutter/material.dart';
import 'package:synkron_app/extensions/camel_case_extension.dart';
import 'package:synkron_app/widgets/molecules/expanded_widget/custom_expanded_panel_widget.dart';
import 'package:expandable/expandable.dart';
import '../../../models/timesheets/timesheets_record_model.dart';
import '../../../styles/colors_theme.dart';
import '../../../styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/expandable/expandable_panel_timesheet_record.dart';

class TimesheetRecordWidget extends StatelessWidget {
  final List<TimesheetRecordModel> timesheetRecord;
  final Function expansionCallback;

  const TimesheetRecordWidget(
      {Key? key,
      required this.timesheetRecord,
      required this.expansionCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: timesheetRecord
          .map<Widget>((e) => ExpandableNotifier(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ScrollOnExpand(
                      scrollOnExpand: true,
                      child: ExpandablePanelTimesheetRecord(
                          timesheetRecordModel: e)),
                ),
              ))
          .toList(),
    );

    /* CustomExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        expansionCallback(index);
      },
      children: timesheetRecord
          .map((e) => CustomExpansionPanel(
                backgroundColor: ColorsTheme.backgroundBlue,
                isExpanded: e.isExpanded,
                canTapOnHeader: false,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(e.week,
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorsTheme.accentBlue2,
                          fontFamily: 'Nunito-Sans',
                        )),
                  );
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: e.timesheet
                      .map((e) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: e.status == 'approved'
                                            ? ColorsTheme.accentGreen
                                            : e.status == 'pending'
                                                ? ColorsTheme.primaryHoverBlue2
                                                : ColorsTheme.destructiveRed,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    height: 24.0,
                                    width: 120.0,
                                    child: Center(
                                      child: Text(
                                        e.status.capitalize(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    e.employee.fullName,
                                    style: TypographyTheme.fontH5,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 45.0,
                                        child: Text(
                                          'Project',
                                          style: TypographyTheme.fontH6,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Flexible(
                                        child: Text(e.projectModel.name),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 45.0,
                                        child: Text(
                                          'Hours',
                                          style: TypographyTheme.fontH6,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Flexible(
                                        child: Text('${e.workedHours} hrs'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
              )
          .toList(),
    ); */
  }
}
