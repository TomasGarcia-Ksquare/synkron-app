import 'package:flutter/material.dart';
import 'package:synkron_app/extensions/camel_case_extension.dart';
import 'package:synkron_app/widgets/molecules/expanded_widget/custom_expanded_panel_widget.dart';
import 'package:expandable/expandable.dart';
import '../../../models/timesheets/timesheets_record_model.dart';
import '../../../styles/colors_theme.dart';
import '../../../styles/font_styles.dart';

class ExpandablePanelTimesheetRecord extends StatefulWidget {
  TimesheetRecordModel timesheetRecordModel;
   ExpandablePanelTimesheetRecord({super.key, required this.timesheetRecordModel});

  @override
  State<ExpandablePanelTimesheetRecord> createState() =>
      _ExpandablePanelTimesheetRecordState();
}

class _ExpandablePanelTimesheetRecordState
    extends State<ExpandablePanelTimesheetRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: ColorsTheme.accentBlue1,
      ),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToCollapse: true,
            iconSize: 24,
            iconColor: ColorsTheme.textColor),
        header: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Text(widget.timesheetRecordModel.week,
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorsTheme.accentBlue2,
                  fontFamily: 'Nunito-Sans',
                ))),
        collapsed: const SizedBox(),
        expanded: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: widget.timesheetRecordModel.timesheet
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
                                borderRadius: BorderRadius.circular(8.0)),
                            height: 24.0,
                            width: 120.0,
                            child: Center(
                              child: Text(
                                e.status.capitalize(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
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
        builder: (_, collapsed, expanded) {
          return Expandable(
            collapsed: collapsed,
            expanded: expanded,
            theme: const ExpandableThemeData(crossFadePoint: 0),
          );
        },
      ),
    );
  }
}
