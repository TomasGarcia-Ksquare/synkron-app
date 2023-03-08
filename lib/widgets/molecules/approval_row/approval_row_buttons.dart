import 'package:flutter/material.dart';

import '../../../models/time_off/manager/myteam_timeoff_requests_model.dart';
import '../../../providers/manager/time_off/myteam_timeoff_request_provider.dart';
import '../../atoms/button/status_buttons_timeoff.dart';

class ApprovalRowButtons extends StatelessWidget {
  final TimeOffRequestsModel timeOffMyTeam;
  final TimeOffRequestsMyTeamProvider myTeamProvider;
  const ApprovalRowButtons(
      {super.key, required this.timeOffMyTeam, required this.myTeamProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ApprovedTimeOffButton(
          myTeamTimeOff: timeOffMyTeam,
          timesOffMyTeamProvider: myTeamProvider,
        ),
        RejectTimeOffButton(
          myTeamTimeOff: timeOffMyTeam,
          timesOffMyTeamProvider: myTeamProvider,
        ),
      ],
    );
  }
}
