import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/models/timesheets/timesheet_model.dart';
import 'package:synkron_app/providers/timesheets/timesheet_approvals_provider.dart';

class ApprovedButton extends StatelessWidget {
  final TimesheetModel timesheet;
  final TimesheetApprovalsProvider approvalsProvider;

  const ApprovedButton(
      {super.key, required this.timesheet, required this.approvalsProvider});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        approvalsProvider.setStatus(timesheet, Status.approved).then(
            (value) => Navigator.popAndPushNamed(context, '/myteamtimesheets'));
      },
      child: Row(
        children: <Widget>[
          const Icon(Icons.check_circle_outlined,
              color: Colors.green, size: 20),
          const SizedBox(width: 6),
          Text('Approved',
              style: TypographyTheme.fontBtnPrimaryBlue.copyWith(fontSize: 14))
        ],
      ),
    );
  }
}

class RejectButton extends StatelessWidget {
  final TimesheetModel timesheet;
  final TimesheetApprovalsProvider approvalsProvider;

  const RejectButton(
      {super.key, required this.timesheet, required this.approvalsProvider});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        approvalsProvider.setStatus(timesheet, Status.reject).then((value) => 
        Navigator.popAndPushNamed(context, '/myteamtimesheets'));
      },
      child: Row(
        children: [
          const Icon(Icons.highlight_off, color: Colors.red, size: 20),
          const SizedBox(width: 6),
          Text('Reject',
              style: TypographyTheme.fontBtnPrimaryBlue.copyWith(fontSize: 14))
        ],
      ),
    );
  }
}
