import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synkron_app/models/filter_model/checkbox_filter.dart';
import 'package:synkron_app/services/timesheets/timesheets_records_services.dart';
import 'package:synkron_app/services/active_projects_services.dart';
import '../../models/timesheets/timesheet_model.dart';
import '../../models/timesheets/timesheets_record_model.dart';
import '../../models/util/ws_rensponse_model.dart';
import '../../utils/utils.dart';
import 'package:synkron_app/models/active_projects_model.dart';

class TimesheetsMyTeamProvider extends ChangeNotifier {
  bool applyFilter = false;
  bool applySort = false;

  // Initialize the TimeSheetServices
  final timesheetServices = TimeSheetServices();
  //Orderby index option (Sort filter)
  int orderByIndexTemp = 0;
  int orderByIndex = 0;

  //Pagination variable, with infinite scroll, this must be incremented
  int pageOffset = 0;

  //Auxiliary variables
  bool isLastPage = false;
  bool firsTimeFetch = false;
  bool firsTimeUpdate = false;
  bool endReachedAux = false;

  //variables for date range
  bool isValidTheDateRange = false;
  String startDate = '';
  String endDate = '';

  // Initialize the timesheetRecord list with an empty list
  List<TimesheetRecordModel> timesheetRecord = [];
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
  bool loadingTimesheetRecords = true;
  bool loadingNewTimesheetRecords = true;

  //Total number of records
  num recordsNum = 0;

  //Name and Id lists of projects
  List nameProjects = [];
  List idProjects = [];

  //-----------------------------------------------------------------------------------------------
  //METHODS
  //-----------------------------------------------------------------------------------------------

  //Method to get the Date range string (only if the “isValidTheDateRange” variable is true, otherwise it would return an empty string.
  String getDateRange() {
    if (isValidTheDateRange) {
      return '"endDate":{"\$lte":"$endDate"},"startDate":{"\$gte":"$startDate"}';
    } else {
      return '';
    }
  }

  //Method to reset the all the timesheet record list and other related variables.
  int resetTimesheetRecord() {
    pageOffset = 0;
    timesheetRecord = [];
    isLastPage = false;
    endReachedAux = true;
    loadingTimesheetRecords = true;
    notifyListeners();
    return 0;
  }

  //Method to set the value of the "loadingNewTimesheetRecords" variable to false (to indicate that the animation of loading new timesheet records should no longer be continued)
  void cancelBottomLoading() {
    loadingNewTimesheetRecords = false;
    notifyListeners();
  }

  //method to reset the necessary variables if the user scrolls to the bottom of the screen
  void endOfPage() {
    loadingTimesheetRecords = false;
    loadingTimesheetRecords = false;
    isLastPage = true;
    notifyListeners();
  }

  //If the variable "firstTimeUpdate" is false, then create the project filter and set "firstTimeUpdate" to true. If "firstTimeUpdate" is true, then it just updates the project filter with the new list of projects.
  void projectUpdate() {
    if (firsTimeUpdate == false) {
      addCheckboxFilterModel("Project", "projectId", nameProjects, idProjects);
      firsTimeUpdate = true;
    } else {
      for (int i = 0; i < checkboxFilterModelTimesheets.length; i++) {
        if (checkboxFilterModelTimesheets[i].filterTitleQuery == "projectId") {
          updateCheckboxFilterModel(i, nameProjects, idProjects);
        }
      }
    }
    notifyListeners();
  }

  //Method to create a new checkbox filter and add it to the "checkboxFilterModelTimesheets" list
  void addCheckboxFilterModel(
      filterTitle, filterTitleQuery, List options, List optionsQuery) {
    List<bool> falseList = [];
    List<bool> falseList2 = [];
    for (int i = 0; i < options.length; i++) {
      falseList.add(false);
      falseList2.add(false);
    }
    checkboxFilterModelTimesheets.add(CheckboxFilterModel(
        filterTitle: filterTitle,
        filterTitleQuery: filterTitleQuery,
        options: options,
        optionsQuery: optionsQuery,
        optionsValues: falseList,
        optionsValuesTemp: falseList2));
    notifyListeners();
  }

  //Method to update the options of a checkbox filter
  void updateCheckboxFilterModel(int index, List options, List optionsQuery) {
    List<bool> falseList = [];
    List<bool> falseList2 = [];
    for (int i = 0; i < options.length; i++) {
      falseList.add(false);
      falseList2.add(false);
    }
    checkboxFilterModelTimesheets[index].options = options;
    checkboxFilterModelTimesheets[index].optionsQuery = optionsQuery;
    checkboxFilterModelTimesheets[index].optionsValues = falseList;
    checkboxFilterModelTimesheets[index].optionsValuesTemp = falseList2;
    notifyListeners();
  }

  //Method to update the temporary value of a checkbox filter option.
  void changeOptionsValuesTemp(int indexGeneral, int indexOption, bool value) {
    checkboxFilterModelTimesheets[indexGeneral].optionsValuesTemp[indexOption] =
        value;
    notifyListeners();
  }

  //Method that must be used every time the checkbox filters are applied, the temporary values of the options are equal to the values that will be sent in the request.
  void updateoptionsValues() {
    for (int i = 0; i < checkboxFilterModelTimesheets.length; i++) {
      for (int j = 0;
          j < checkboxFilterModelTimesheets[i].optionsValues.length;
          j++) {
        checkboxFilterModelTimesheets[i].optionsValues[j] =
            checkboxFilterModelTimesheets[i].optionsValuesTemp[j];
      }
    }
    //Orderby index
    orderByIndex = orderByIndexTemp;
    notifyListeners();
  }

  //Method to update the temporary values of the checkbox filters with the last values that were sent in an http request. This allows that each time the filters are opened, they have the values that are really active
  void inverseUpdateOptionsValues() {
    for (int i = 0; i < checkboxFilterModelTimesheets.length; i++) {
      for (int j = 0;
          j < checkboxFilterModelTimesheets[i].optionsValues.length;
          j++) {
        checkboxFilterModelTimesheets[i].optionsValuesTemp[j] =
            checkboxFilterModelTimesheets[i].optionsValues[j];
      }
    }

    orderByIndexTemp = orderByIndex;
    notifyListeners();
  }

  //Method to assign as falsetheall the  checkboxes (temporary) values in the filters.
  void clearFiltersValues() {
    for (int i = 0; i < checkboxFilterModelTimesheets.length; i++) {
      for (int j = 0;
          j < checkboxFilterModelTimesheets[i].optionsValuesTemp.length;
          j++) {
        checkboxFilterModelTimesheets[i].optionsValuesTemp[j] = false;
      }
    }
    notifyListeners();
  }

  //Method that returns the “where” String, according to the current values of the variables and related functions (implicitly executes the "updateoptionsValues()" method)
  String updateStatusFilter() {
    updateoptionsValues();
    String where = '';
    int numberTrueTotal = checkboxFilterModelTimesheets
        .where((element) => element.optionsValues.contains(true))
        .length;

    int totalCounter = 1;

    for (int i = 0; i < checkboxFilterModelTimesheets.length; i++) {
      if (checkboxFilterModelTimesheets[i].optionsValues.contains(true)) {
        int numberTrue = checkboxFilterModelTimesheets[i]
            .optionsValues
            .where((val) => val == true)
            .length;
        int counter = 1;
        String stringFilter =
            '"${checkboxFilterModelTimesheets[i].filterTitleQuery}":[';

        for (int j = 0;
            j < checkboxFilterModelTimesheets[i].optionsValues.length;
            j++) {
          if (checkboxFilterModelTimesheets[i].optionsValues[j] == true) {
            if (counter < numberTrue) {
              stringFilter =
                  '$stringFilter${checkboxFilterModelTimesheets[i].optionsQuery[j]},';
              counter++;
            } else {
              stringFilter =
                  '$stringFilter${checkboxFilterModelTimesheets[i].optionsQuery[j]}';
            }
          }
        }

        if (totalCounter < numberTrueTotal) {
          stringFilter = "$stringFilter],";

          totalCounter++;
        } else {
          stringFilter = "$stringFilter]";
        }

        where = where + stringFilter;
      }
    }

    return where;
  }

  //Method to obtain the active projects of the employee who logged in
  Future<List<ActiveProjectsModel>> getProjects() async {
    List tempNameProjects = [];
    List tempidProjects = [];

    WsResponse wsResponse = await ActiveProjectsServices().getActiveProjects();

    //-----------------------------------------------
    if (wsResponse.success) {
      // Get the data from the api response
      dynamic bodyResponse = wsResponse.data;

      // If there is no data in the response
      if (bodyResponse == null) {
        return [];
      }
      // Get the timesheet record list from the response data
      List data = bodyResponse['data'];

      List<ActiveProjectsModel> newActiveProjectsModel = [];
      // Map the timesheet record list to the TimesheetRecordModel
      newActiveProjectsModel = data
          .map<ActiveProjectsModel>(
              (project) => ActiveProjectsModel.fromJson(project))
          .toList();

      for (int i = 0; i < newActiveProjectsModel.length; i++) {
        tempNameProjects
            .add(newActiveProjectsModel[i].projectPosition!.project!.name);
        tempidProjects
            .add(newActiveProjectsModel[i].projectPosition!.projectId);
      }
      nameProjects = tempNameProjects;
      idProjects = tempidProjects;

      //print("los projectos son: $nameProjects");

      notifyListeners();

      return newActiveProjectsModel;
    }
    return [];
  }

  // Method that is adding Timesheet Records to the current list of timesheetRecord in batches of default number in the http function in the services, the variable "numberOfPage" must be increased to avoid fetching duplicate data.
  Future<List<TimesheetRecordModel>> getTimesheetRecords(int numberOfPage,
      {bool employee = false}) async {
    if (isLastPage == false) {
      loadingNewTimesheetRecords = true;
      notifyListeners();

      String filterWhere = updateStatusFilter();

      if (isValidTheDateRange) {
        if (filterWhere == '') {
          filterWhere = filterWhere + getDateRange();
        } else {
          filterWhere = '$filterWhere,${getDateRange()}';
        }
      }

      String startDate = 'startDate';
      String orderBy = 'DESC';
      if (orderByIndex == 1) {
        orderBy = 'ASC';
      } else if (orderByIndex == 2) {
        startDate = 'updatedAt';
      }
      // Clear the timesheetRecord list
      List<TimesheetRecordModel> newTimesheetRecord = [];
      // Get the timesheet records from the api
      WsResponse wsResponse = await timesheetServices.getMyTeamTimesheet(
          numberOfPage, filterWhere, startDate, orderBy);

      loadingTimesheetRecords = false;

      cancelBottomLoading();
      notifyListeners();
      // If the api call was successful
      if (wsResponse.success) {
        // Get the data from the api response
        dynamic bodyResponse = wsResponse.data;

        // If there is no data in the response
        if (bodyResponse == null) {
          loadingTimesheetRecords = false;
          notifyListeners();
          return [];
        }
        // Get the timesheet record list from the response data
        List data = bodyResponse['data'];
        if (data.isEmpty) {
          loadingTimesheetRecords = false;
          loadingNewTimesheetRecords = false;
          notifyListeners();

          endOfPage();
          cancelBottomLoading();

          notifyListeners();

          return [];
        } else {
          recordsNum = bodyResponse['count'];

          // Map the timesheet record list to the TimesheetRecordModel
          newTimesheetRecord = data.map((e) {
            List<TimesheetModel> tempTimesheetModel = [];

            for (int i = 0; i < e['employees'].length; i++) {
              tempTimesheetModel.addAll((e['employees'][i]['timesheets'] as List).map((timesheet) {
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
            }
            return TimesheetRecordModel(
                week:
                    'Week ${Utils.formatDate(date: e['startDate'], format: DateFormatInterface.MM_DD_YY)} - ${Utils.formatDate(date: e['endDate'], format: DateFormatInterface.MM_DD_YY)}',
                timesheet: tempTimesheetModel
                    
                    
                    );
          }).toList();

          timesheetRecord.addAll(newTimesheetRecord);

          firsTimeFetch = true;

          loadingTimesheetRecords = false;
          loadingNewTimesheetRecords = false;

          notifyListeners();

          return timesheetRecord;
        }
      }
      cancelBottomLoading();
      notifyListeners();
      return [];
    } else {
      cancelBottomLoading();
      notifyListeners();
      //Here will go the code when the user reaches the last page
      /* loadingTimesheetRecords = false;
      loadingNewTimesheetRecords = false;
      notifyListeners(); */
      return [];
    }
  }

  //Method that is used to expand or collapse the timesheet record at the given index
  void expandTimesheetRecord(int index) {
    // This function is used to expand or collapse the timesheet record at the given index
    timesheetRecord[index].isExpanded = !timesheetRecord[index].isExpanded;
    notifyListeners();
  }

//Method that is used to expand or collapse the timesheet status in filter
  void expandFilters(int index) {
    // This function is used to expand or collapse the timesheet status in filter
    checkboxFilterModelTimesheets[index].isExpanded =
        !checkboxFilterModelTimesheets[index].isExpanded;
    notifyListeners();
  }

  //Method that is used to expand or collapse the work shift records
  void expandNumberTextfield(int index) {
    workShiftRecordModel[index].isExpanded =
        !workShiftRecordModel[index].isExpanded;
    notifyListeners();
  }
}
