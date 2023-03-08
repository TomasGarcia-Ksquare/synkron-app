import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:synkron_app/models/filter_model/checkbox_filter.dart';
import '../../models/timesheets/timesheets_record_model.dart';
import '../../services/timesheets/timesheet_approvals_services.dart';
import '../../models/timesheets/timesheet_model.dart';
import '../../models/timesheets/timesheets_expandtree_model.dart';
import '../../models/util/ws_rensponse_model.dart';
import '../../utils/utils.dart';

class TimesheetEditHoursProvider extends ChangeNotifier {
  String workedHours = "";

  late List<TimesheetModel> myTeam;
  late TimesheetModel actualTimesheet;
  late List<WorkShiftModel> actualWorkShiftList;
  String actualProjectName = "";
  List<WorkShiftRecordModel> workShiftRecordModel = [];

  //Method that is used to expand or collapse the work shift records
  void expandNumberTextfield(int index) {
    workShiftRecordModel[index].isExpanded =
        !workShiftRecordModel[index].isExpanded;
    notifyListeners();
  }

  List<WorkShiftRecordModel> fillWorkShiftRecordModel() {
    List<WorkShiftRecordModel> workShiftRecordModels = [];
    final days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
    for (var element in days) {
      workShiftRecordModels
          .add(WorkShiftRecordModel(day: element, isExpanded: false));
    }
    workShiftRecordModel = workShiftRecordModels;
    print(workShiftRecordModels);
    return workShiftRecordModels;
  }

  List<int> getWorkedHoursDivision(String workedHours) {
    int total = int.parse(workedHours);
    List<int> week = [];
    if (total % 5 == 0) {
      int hours = (total ~/ 5);
      for (int i = 0; i < 5; i++) {
        week.add(hours);
      }
    } else {
      int hoursPerDay = total ~/ 5;
      print(hoursPerDay);
      int fridayHours = total - (hoursPerDay * 4);
      for (int i = 0; i < 4; i++) {
        week.add(hoursPerDay);
      }
      week.add(fridayHours);
    }
    print(week);
    return week;
  }

  bool isTextFormFieldFilled(Map<String, TextEditingController> controllers) {
    bool isFilled = true;
    controllers.forEach((key, value) {
      if (value.text.isEmpty) {
        isFilled = false;
      }
    });
    return isFilled;
  }

  // Formatting days methods

  List<String> getOrderedHours() {
    actualWorkShiftList.sort((a, b) => a.date.compareTo(b.date));
    List<WorkShiftModel> orderedShiftList = actualWorkShiftList;
    List<String> hours = [];
    List<String> dates = [];
    for (int i = 0; i < 5; i++) {
      hours.add(orderedShiftList[i].hours);
      dates.add(orderedShiftList[i].date);
    }
    return hours;
  }

  List<String> getProjectTitles(List<TimesheetModel> myTeam) {
    List<String> projectNames = [];
    myTeam.forEach((element) {
      projectNames.add(element.projectModel.name);
    });
    return projectNames;
  }

  String setWorkedHours(String hours) {
    workedHours = hours;
    return workedHours;
  }

  String setProjectName(String projectName) {
    actualProjectName = projectName;
    return actualProjectName;
  }

  void setMyTeam(List<TimesheetModel> mT) {
    myTeam = mT;
    if (isEmptyProjectName()) {
      actualProjectName = myTeam[0].projectModel.name;
    }
    actualTimesheet = getActualTimesheet();
    print(actualTimesheet);
  }

  List<WorkShiftModel> selectWorkShift() {
    actualWorkShiftList = actualTimesheet.workShiftList;

    return actualWorkShiftList;
  }

  TimesheetModel getActualTimesheet() {
    myTeam.forEach((element) {
      if (element.projectModel.name == actualProjectName) {
        actualTimesheet = element;
        workedHours = element.workedHours;
      }
    });
    selectWorkShift();

    return actualTimesheet;
  }

  bool isEmptyProjectName() {
    return actualProjectName == "";
  }
}
