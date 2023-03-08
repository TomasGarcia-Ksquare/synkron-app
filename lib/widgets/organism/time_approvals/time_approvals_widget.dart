import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/molecules/approval_card/approval_card.dart';
import 'package:synkron_app/widgets/molecules/expanded_widget/custom_expanded_panel_widget.dart';
import 'package:synkron_app/models/timesheets/timesheets_expandtree_model.dart';
import 'package:synkron_app/providers/timesheets/timesheet_approvals_provider.dart';

import '../../../providers/timesheets/timesheet_edithours_provider.dart';

class TimeApprovals extends StatelessWidget {
  final List<ApprovalExpandTreeModel> timesheetApprovals;
  final Function expansionCallback;
  final TimesheetApprovalsProvider approvalsProvider;
  final TimesheetEditHoursProvider editHoursProvider;

  const TimeApprovals(
      {super.key,
      required this.expansionCallback,
      required this.timesheetApprovals,
      required this.approvalsProvider,
      required this.editHoursProvider});

  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        expansionCallback(index);
      },
      children: timesheetApprovals
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
                body: ApprovalCard(
                  timesheetModel: e.timesheetMyTeam,
                  approvalsProvider: approvalsProvider,
                  editHoursProvider: editHoursProvider,
                ),
              ))
          .toList(),
    );
  }
}
