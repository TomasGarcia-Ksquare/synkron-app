import 'package:synkron_app/models/timesheets/timesheet_model.dart';

class TimesheetExpandTreeModel {
  final String week;
  bool isExpanded;
  final List<TimesheetModel> timesheet;

  TimesheetExpandTreeModel(
      {required this.week, required this.timesheet, this.isExpanded = false});
}

class ApprovalExpandTreeModel {
  final String week;
  bool isExpanded;
  final List<TimesheetMyTeam> timesheetMyTeam;

  ApprovalExpandTreeModel(
      {required this.week, required this.timesheetMyTeam, this.isExpanded = false});
}
