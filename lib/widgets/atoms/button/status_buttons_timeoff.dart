import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
//import 'package:synkron_app/models/timesheets/timesheet_model.dart';
import '../../../models/time_off/manager/myteam_timeoff_requests_model.dart';
import '../../../providers/manager/time_off/myteam_timeoff_request_provider.dart';

class ApprovedTimeOffButton extends StatelessWidget {
  final TimeOffRequestsModel myTeamTimeOff;
  final TimeOffRequestsMyTeamProvider timesOffMyTeamProvider;

  const ApprovedTimeOffButton(
      {super.key,
      required this.myTeamTimeOff,
      required this.timesOffMyTeamProvider});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        timesOffMyTeamProvider.setStatus(myTeamTimeOff, StateModel.approved);
        Navigator.pushReplacementNamed(context, '/myteamtimeoff');
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

class RejectTimeOffButton extends StatelessWidget {
  final TimeOffRequestsModel myTeamTimeOff;
  final TimeOffRequestsMyTeamProvider timesOffMyTeamProvider;

  const RejectTimeOffButton(
      {super.key,
      required this.myTeamTimeOff,
      required this.timesOffMyTeamProvider});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        timesOffMyTeamProvider.setStatus(myTeamTimeOff, StateModel.reject);
        Navigator.pushReplacementNamed(context, '/myteamtimeoff');
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
