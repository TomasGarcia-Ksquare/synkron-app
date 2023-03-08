import 'package:flutter/material.dart';
import 'package:synkron_app/providers/timesheets/timesheet_edithours_provider.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/atoms/button/status_buttons.dart';
import 'package:synkron_app/models/timesheets/timesheet_model.dart';
import 'package:synkron_app/providers/timesheets/timesheet_approvals_provider.dart';

import '../../organism/modal_edit_hours/modal_edit_hours.dart';
import '../modal/custom_bottom_modal.dart';
import '../modal/modal_canva_widget.dart';

class ApprovalCard extends StatelessWidget {
  final List<TimesheetMyTeam> timesheetModel;
  final TimesheetApprovalsProvider approvalsProvider;
  final TimesheetEditHoursProvider editHoursProvider;

  const ApprovalCard(
      {super.key,
      required this.timesheetModel,
      required this.approvalsProvider,
      required this.editHoursProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: timesheetModel.map<Widget>((e) {
        if (e.myTeam.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Container(
                height: 50,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xffececed),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.myTeam.first.employee.fullName,
                        style: TypographyTheme.fontH5
                            .copyWith(color: ColorsTheme.accentBlue3)),
                    GestureDetector(
                        onTap: () async {
                          editHoursProvider.setMyTeam(e.myTeam);
                          CustomBottomModal().customShowModalBottomSheet(
                              context,
                              ModalCanvaWidget(
                                widget: TimesheetEditHoursWidget(
                                  workedHours: editHoursProvider.workedHours,
                                  providerTimesheets: approvalsProvider,
                                  providerEditTimesheets: editHoursProvider,
                                  myTeam: editHoursProvider.myTeam,
                                ),
                              ));
                        },
                        child: const Icon(Icons.edit,
                            color: ColorsTheme.accentBlue3))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffececed), width: 2),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Project',
                          style: TypographyTheme.fontH5
                              .copyWith(color: ColorsTheme.accentBlue2)),
                      Text('Total',
                          style: TypographyTheme.fontH5
                              .copyWith(color: ColorsTheme.accentBlue2))
                    ],
                  ),

                  // e.myTeam.map<Widget>((e) => const Text('data')).toList(),

                  ProjectHrsInfoRequest(
                      timesheet: e.myTeam,
                      approvalsProvider: approvalsProvider),
                ]),
              ),
            ]),
          );
        } else {
          return const SizedBox(height: 20);
        }
      }).toList(),
    );
  }
}

class ProjectHrsInfoRequest extends StatelessWidget {
  final List<TimesheetModel> timesheet;
  final TimesheetApprovalsProvider approvalsProvider;

  const ProjectHrsInfoRequest(
      {super.key, required this.timesheet, required this.approvalsProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: timesheet
            .map<Widget>(
              (e) => SizedBox(
                height: 120,
                child: Column(
                  children: [
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 240, child: Text(e.projectModel.name)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.workedHours,
                              style: TypographyTheme.fontBody1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RejectButton(
                            timesheet: e, approvalsProvider: approvalsProvider),
                        ApprovedButton(
                            timesheet: e, approvalsProvider: approvalsProvider),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList());
  }
}
