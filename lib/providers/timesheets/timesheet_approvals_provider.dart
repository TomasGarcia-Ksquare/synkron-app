import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:synkron_app/models/filter_model/checkbox_filter.dart';
import '../../models/timesheets/timesheets_record_model.dart';
import '../../services/timesheets/timesheet_approvals_services.dart';
import '../../models/timesheets/timesheet_model.dart';
import '../../models/timesheets/timesheets_expandtree_model.dart';
import '../../models/util/ws_rensponse_model.dart';
import '../../utils/utils.dart';

class TimesheetApprovalsProvider extends ChangeNotifier {
  // Initialize the TimeSheetApprovalsServices
  final timesheetApprovalsServices = TimesheetApprovalsServices();

  // Initialize the timesheetApprovals list with an empty list
  List<ApprovalExpandTreeModel> timesheetApprovals = [];
  List<WorkShiftRecordModel> workShiftRecordModel = [];

  //Initialize the checkbox filters

  List<CheckboxFilterModel> checkboxFilterModelTimesheets = [
    CheckboxFilterModel(
        filterTitle: "Status",
        filterTitleQuery: "status",
        options: ["Pending", "Rejected", "Approved", "Draft"],
        optionsQuery: ['"pending"', '"rejected"', '"approved"', '"draft"'],
        optionsValues: [false, false, false, false], //final
        optionsValuesTemp: [false, false, false, false]),
    //checkbox
  ];

  // Initialize the loading status variables with true
  bool loadingTimesheetInfo = true;
  bool loadingTimesheetApprovals = true;

  //Total number of approvals
  num approvalsNum = 0;

  //Timesheet applovals filter window is active?
  bool filterWindow = false;

  //Index of sort

  //map of projects

  List nameProjects = [];
  List idProjects = [];

  void projectUpdate() {
    addCheckboxFilterModel("Project", "projectId", nameProjects, idProjects);
  }

  //Orderby index
  int orderByIndex = 0;

  void addCheckboxFilterModel(
      filterTitle, filterTitleQuery, List options, List optionsQuery) {
    List<bool> falseList = [];
    for (int i = 0; i < options.length; i++) {
      falseList.add(false);
    }
    checkboxFilterModelTimesheets.add(CheckboxFilterModel(
        filterTitle: filterTitle,
        filterTitleQuery: filterTitleQuery,
        options: options,
        optionsQuery: optionsQuery,
        optionsValues: falseList,
        optionsValuesTemp: falseList));
  }

  void changeOptionsValuesTemp(int indexGeneral, int indexOption, bool value) {
    checkboxFilterModelTimesheets[indexGeneral].optionsValuesTemp[indexOption] =
        value;
    notifyListeners();
  }

  //Timesheet approvals filter window change value
  changeFilterWindow() {
    filterWindow = !filterWindow;
    notifyListeners();
  }

  // Function to get timesheet approvals from the api 
  Future<void> getTimesheetAppovals(int numberOfPage,
      {bool employee = false}) async {
    String startDate = 'startDate';
    String orderBy = 'DESC';
    if (orderByIndex == 1) {
      orderBy = 'ASC';
    } else if (orderByIndex == 2) {
      startDate = 'updatedAt';
    }
    // Clear the timesheetApproval list
    timesheetApprovals = [];
    // Get the timesheet approvals from the api
    WsResponse wsResponse = await timesheetApprovalsServices
        .getUserTeamTimesheets(numberOfPage, startDate, orderBy);

    // If the api call was successful
    if (wsResponse.success) {
      // Get the data from the api response
      dynamic bodyResponse = wsResponse.data;

      // If there is no data in the response
      if (bodyResponse == null) {
        return;
      }
      // Get the timesheet approval list from the response data
      List data = bodyResponse['data'];
      approvalsNum = bodyResponse['count'];
      Map tempProject = {};
      List tempNameProjects = [];
      List tempidProjects = [];
      // Map the timesheet appraval list to the TimesheetMyTeam
      timesheetApprovals = data.map((e) {
        return ApprovalExpandTreeModel(
            week:
                'Week ${Utils.formatDate(date: e['startDate'], format: DateFormatInterface.MM_DD_YY)} - ${Utils.formatDate(date: e['endDate'], format: DateFormatInterface.MM_DD_YY)}',
            timesheetMyTeam: (e['employees']).map<TimesheetMyTeam>((employee) {
              return TimesheetMyTeam(
                  id: employee['id'],
                  myTeam: (employee['timesheets'] as List).map((timesheet) {
                    tempProject.addAll({
                      timesheet['project']['name']: timesheet['project']['id']
                    });
                    return TimesheetModel(
                        id: timesheet['id'],
                        status: timesheet['status'],
                        comment: timesheet['comment'],
                        startDate: timesheet['startDate'],
                        workedHours: timesheet['workedHours'],
                        endDate: timesheet['endDate'],
                        projectModel: ProjectModel(
                            id: timesheet['project']['id'],
                            name: timesheet['project']['name'],
                            description: timesheet['project']['description']),
                        employee: TimesheetEmployee(
                            id: timesheet['employee']['id'],
                            fullName: timesheet['employee']['fullName'],
                            secondLastName: timesheet['employee']
                                ['secondLastName'],
                            middleName: timesheet['employee']['middleName'],
                            lastName: timesheet['employee']['lastName'],
                            firstName: timesheet['employee']['firstName']),
                        workShiftList: (timesheet['workShiftList'] as List)
                            .map((workShift) => WorkShiftModel(
                                timesheetId: workShift['timesheetId'],
                                id: workShift['id'],
                                date: workShift['date'],
                                updatedAt: workShift['updatedAt'],
                                hours: workShift['hours'],
                                createdAt: workShift['createdAt']))
                            .toList());
                  }).toList());
            }).toList());
      }).toList();
      tempProject.forEach((key, value) {
        tempNameProjects.add(key);
        tempidProjects.add(value);
      });

      nameProjects = tempNameProjects;
      idProjects = tempidProjects;

      loadingTimesheetApprovals = false;

      notifyListeners();
    }
  }

  void expandTimesheetApprovals(int index) {
    // This function is used to expand or collapse the timesheet approval at the given index
    timesheetApprovals[index].isExpanded =
        !timesheetApprovals[index].isExpanded;
    notifyListeners();
  }

  void expandFilters(int index) {
    // This function is used to expand or collapse the timesheet status in filter
    checkboxFilterModelTimesheets[index].isExpanded =
        !checkboxFilterModelTimesheets[index].isExpanded;
    notifyListeners();
  }

  Future setStatus(TimesheetModel timesheet, String status) {
    // Set status to a timesheet
    var answer = timesheetApprovalsServices.putStatusTeamTimesheets(
        timesheet.id, status);

    timesheetApprovals = timesheetApprovals
        .map<ApprovalExpandTreeModel>((tree) => ApprovalExpandTreeModel(
            week: tree.week,
            timesheetMyTeam: tree.timesheetMyTeam
                .map((teamSheet) => TimesheetMyTeam(
                    id: teamSheet.id,
                    myTeam: teamSheet.myTeam
                        .where((sheet) => sheet.id != timesheet.id)
                        .toList()))
                .toList()))
        .toList();

    ChangeNotifier();
    return answer;
  }
}
