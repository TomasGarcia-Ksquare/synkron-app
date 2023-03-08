import 'package:synkron_app/models/timesheets/timesheet_model.dart';

class TimesheetRecordModel {
  final String week;
  bool isExpanded;
  final List<TimesheetModel> timesheet;

  TimesheetRecordModel(
      {required this.week, required this.timesheet, this.isExpanded = false});
}

class WorkShiftRecordModel {
  final String day;
  bool isExpanded;
  /* final List<WorkShiftModel> timesheet; */

  WorkShiftRecordModel(
      {required this.day,
      /* required this.timesheet, */ this.isExpanded = false});
}
