import 'dart:core';
import 'package:flutter/material.dart';

import '../../../models/time_off/employee/employee_timeoff_records_model.dart';
import '../../../models/filter_model/checkbox_filter.dart';
import '../../../models/util/ws_rensponse_model.dart';
import '../../../services/time_off/employee_timeoff_records_services.dart';
import '../../../services/employee/employee_service.dart';
import '../../../utils/utils.dart';

class TimeOffRecordsEmployeeProvider extends ChangeNotifier {
  // Initialize the service TimeOffRecordsEmployeeServices
  final timeOffRecordsEmployeeService = TimeOffRecordsEmployeeServices();

  //Orderby index option (Sort filter)
  int orderByIndex = 0;
  int orderByIndexTemp = 0;

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

  // Initialize the time off request list with an empty list
  List<TimeOffEmployeeRecordsModel> timeOffRequestsList = [];

  //Initialize the checkbox filters for State/Status
  List<CheckboxFilterModel> checkboxFilterModelTimeOffRequest = [
    CheckboxFilterModel(
        filterTitle: "State",
        filterTitleQuery: "state",
        options: ["Approved", "Rejected", "Requested", "Canceled"],
        optionsQuery: ['"approved"', '"rejected"', '"requested"', '"canceled"'],
        optionsValues: [false, false, false, false],
        optionsValuesTemp: [false, false, false, false]),
    //checkbox
  ];

  // Initialize the loading status variables with true
  bool loadingTimeOffRequestInfo = true;
  bool loadingTimeOffRequests = true;
  bool loadingNewTimeOffRequests = true;

  //Total number of time off records
  num recordsNum = 0;

  //map of Events, names and id
  List nameEvents = []; //Benefit
  List idEvents = []; //BenefitId

  /* METHODS */

  //Method to get the Date range string (only if the “isValidTheDateRange” variable is true, otherwise it would return an empty string.
  String getDateRange() {
    if (isValidTheDateRange) {
      return '"endDate":{"\$lte":"$endDate"},"startDate":{"\$gte":"$startDate"}';
    } else {
      return '';
    }
  }

  //Method to reset the all the time off record list and other related variables.
  int resetTimeOffRequest() {
    pageOffset = 0;
    timeOffRequestsList = [];
    isLastPage = false;
    endReachedAux = true;
    loadingTimeOffRequests = true;
    notifyListeners();
    return 0;
  }

  //Method to set the value of the "loadingNewTimeOffRequests" variable to false (to indicate that the animation of loading new time off requests should no longer be continued)
  void cancelBottomLoading() {
    loadingNewTimeOffRequests = false;
    notifyListeners();
  }

  //method to reset the necessary variables if the user scrolls to the bottom of the screen
  void endOfPage() {
    loadingTimeOffRequests = false;
    loadingTimeOffRequests = false;
    isLastPage = true;
    notifyListeners();
  }

  //If the variable "firsTimeUpdate" is false, then create the benefit filter and set "firsTimeUpdate" to true. If "firsTimeUpdate" is true, then it just updates the benefit filter with the new list of benefits
  void eventUpdate() {
    if (firsTimeUpdate == false) {
      addCheckboxFilterModel("Benefit", "benefitId", nameEvents, idEvents);
      firsTimeUpdate = true;
    } else {
      for (int i = 0; i < checkboxFilterModelTimeOffRequest.length; i++) {
        if (checkboxFilterModelTimeOffRequest[i].filterTitleQuery ==
            "benefitId") {
          updateCheckboxFilterModel(i, nameEvents, idEvents);
        }
      }
    }
    notifyListeners();
  }

  //Method to create a new checkbox filter and add it to the "checkboxFilterModelTimeOffRequest" list
  void addCheckboxFilterModel(
      filterTitle, filterTitleQuery, List options, List optionsQuery) {
    List<bool> falseList = [];
    List<bool> falseList2 = [];
    for (int i = 0; i < options.length; i++) {
      falseList.add(false);
      falseList2.add(false);
    }
    checkboxFilterModelTimeOffRequest.add(CheckboxFilterModel(
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
    checkboxFilterModelTimeOffRequest[index].options = options;
    checkboxFilterModelTimeOffRequest[index].optionsQuery = optionsQuery;
    checkboxFilterModelTimeOffRequest[index].optionsValues = falseList;
    checkboxFilterModelTimeOffRequest[index].optionsValuesTemp = falseList2;
    notifyListeners();
  }

  //Method to update the temporary value of a checkbox filter option.
  void changeOptionsValuesTemp(int indexGeneral, int indexOption, bool value) {
    checkboxFilterModelTimeOffRequest[indexGeneral]
        .optionsValuesTemp[indexOption] = value;
    notifyListeners();
  }

  //Method that must be used every time the checkbox filters are applied, the temporary values of the options are equal to the values that will be sent in the request.
  void updateoptionsValues() {
    for (int i = 0; i < checkboxFilterModelTimeOffRequest.length; i++) {
      for (int j = 0;
          j < checkboxFilterModelTimeOffRequest[i].optionsValues.length;
          j++) {
        checkboxFilterModelTimeOffRequest[i].optionsValues[j] =
            checkboxFilterModelTimeOffRequest[i].optionsValuesTemp[j];
      }
    }
    orderByIndex = orderByIndexTemp;
    notifyListeners();
  }

  //Method to update the temporary values of the checkbox filters with the last values that were sent in an http request. This allows that each time the filters are opened, they have the values that are really active
  void inverseUpdateOptionsValues() {
    for (int i = 0; i < checkboxFilterModelTimeOffRequest.length; i++) {
      for (int j = 0;
          j < checkboxFilterModelTimeOffRequest[i].optionsValues.length;
          j++) {
        checkboxFilterModelTimeOffRequest[i].optionsValuesTemp[j] =
            checkboxFilterModelTimeOffRequest[i].optionsValues[j];
      }
    }

    orderByIndexTemp = orderByIndex;
    notifyListeners();
  }

  //Method to assign as falsetheall the  checkboxes (temporary) values in the filters.
  void clearFiltersValues() {
    for (int i = 0; i < checkboxFilterModelTimeOffRequest.length; i++) {
      for (int j = 0;
          j < checkboxFilterModelTimeOffRequest[i].optionsValuesTemp.length;
          j++) {
        checkboxFilterModelTimeOffRequest[i].optionsValuesTemp[j] = false;
      }
    }
    notifyListeners();
  }

  //Method that returns the “where” String, according to the current values of the variables and related functions (implicitly executes the "updateoptionsValues()" method)
  String updateStatusFilter() {
    updateoptionsValues();
    String where = '';
    int numberTrueTotal = checkboxFilterModelTimeOffRequest
        .where((element) => element.optionsValues.contains(true))
        .length;

    int totalCounter = 1;

    for (int i = 0; i < checkboxFilterModelTimeOffRequest.length; i++) {
      if (checkboxFilterModelTimeOffRequest[i].optionsValues.contains(true)) {
        int numberTrue = checkboxFilterModelTimeOffRequest[i]
            .optionsValues
            .where((val) => val == true)
            .length;
        int counter = 1;
        String stringFilter =
            '"${checkboxFilterModelTimeOffRequest[i].filterTitleQuery}":[';

        for (int j = 0;
            j < checkboxFilterModelTimeOffRequest[i].optionsValues.length;
            j++) {
          if (checkboxFilterModelTimeOffRequest[i].optionsValues[j] == true) {
            if (counter < numberTrue) {
              stringFilter =
                  '$stringFilter${checkboxFilterModelTimeOffRequest[i].optionsQuery[j]},';
              counter++;
            } else {
              stringFilter =
                  '$stringFilter${checkboxFilterModelTimeOffRequest[i].optionsQuery[j]}';
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

  //Method to obtain the active benefits of the employee who logged in
  Future<List<BenefitsEmployeeModel>> getBenefits() async {
    List tempNameEvents = []; //benefit
    List tempIdEvents = []; //benefitId

    WsResponse wsResponse =
        await EmployeeService().fetchEmployeeTimeOffBalance();

    // -------------------------------------------------------------------
    if (wsResponse.success) {
      // Get the data from the api response
      dynamic bodyResponse = wsResponse.data;

      // If there is no data in the response
      if (bodyResponse == null) {
        return [];
      }

      // Get the timesheet record list from the response data
      List data = bodyResponse['data'];

      List<BenefitsEmployeeModel> newBenefitsList = [];
      //Map the benefits list to the BenefitModel
      newBenefitsList = data
          .map<BenefitsEmployeeModel>(
              (benefit) => BenefitsEmployeeModel.fromJson(benefit))
          .toList();

      for (int i = 0; i < newBenefitsList.length; i++) {
        tempNameEvents.add(newBenefitsList[i].displayName);
        tempIdEvents.add(newBenefitsList[i].benefitId);
      }

      nameEvents = tempNameEvents;
      idEvents = tempIdEvents;

      notifyListeners();
      return newBenefitsList;
    }
    return [];
  }

  // Function to get time off records from the api
  Future<List<TimeOffEmployeeRecordsModel>> getTimeOffRecords(int numberOfPage,
      {bool employee = false}) async {
    if (isLastPage == false) {
      loadingNewTimeOffRequests = true;
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

      // Clear the time off request list
      List<TimeOffEmployeeRecordsModel> newTimeOffRequestsList = [];

      // Get the time off records from the api
      WsResponse wsResponse =
          await timeOffRecordsEmployeeService.getTimeOffRecordsEmployee(
              numberOfPage, filterWhere, startDate, orderBy);

      loadingTimeOffRequests = false;

      cancelBottomLoading();
      notifyListeners();

      // If the api call was successful
      if (wsResponse.success) {
        // Get the data from the api response
        dynamic bodyResponse = wsResponse.data;

        // If there is no data in the response
        if (bodyResponse == null) {
          loadingTimeOffRequests = false;
          notifyListeners();
          return [];
        }

        // Get the time off record list from the response data
        List data = bodyResponse['data'];

        if (data.isEmpty) {
          loadingTimeOffRequests = false;
          loadingNewTimeOffRequests = false;
          notifyListeners();

          endOfPage();
          cancelBottomLoading();

          notifyListeners();
          return [];
        } else {
          recordsNum = bodyResponse['count'];

          //Map tempEvents = {}; //events
          //List tempNameEvents = []; //events
          //List tempIdEvents = []; //events

          // Mapa {} timeoff records list a TimeOffRequestsModel
          newTimeOffRequestsList = data.map((e) {
            //tempEvents
            //.addAll({e['benefit']['displayName']: e['benefit']['id']});
            return TimeOffEmployeeRecordsModel(
              id: e['id'],
              approvedAt: e['approvedAt'] == null
                  ? 'null'
                  : Utils.formatDate(
                      date: e['approvedAt'],
                      format: DateFormatInterface.MM_DD_YY),
              startDate: Utils.formatDate(
                  date: e['startDate'], format: DateFormatInterface.MM_DD_YY),
              endDate: Utils.formatDate(
                  date: e['endDate'], format: DateFormatInterface.MM_DD_YY),
              state: e['state'],
              isCancelPending: e['isCancelPending'],
              isInAdvance: e['isInAdvance'],
              isInPast: e['isInPast'],
              approverId: e['approverId'],
              employeeId: e['employeeId'],
              benefitId: e['benefitId'],
              createdAt: e['createAt'] == null
                  ? 'null'
                  : Utils.formatDate(
                      date: e['createAt'],
                      format: DateFormatInterface.MM_DD_YY),
              updatedAt: e['updateAt'] == null
                  ? 'null'
                  : Utils.formatDate(
                      date: e['updateAt'],
                      format: DateFormatInterface.MM_DD_YY),
              benefit: BenefitModel(
                id: e['benefit']['id'], //este
                name: e['benefit']['name'],
                displayName: e['benefit']['displayName'], //este
                description: e['benefit']['description'],
                type: e['benefit']['type'],
                status: e['benefit']['status'],
                updatedById: e['benefit']['updatedById'] ?? 0,
                createdAt: Utils.formatDate(
                    date: e['benefit']['createdAt'],
                    format: DateFormatInterface.MM_DD_YY),
                updatedAt: Utils.formatDate(
                    date: e['benefit']['updatedAt'],
                    format: DateFormatInterface.MM_DD_YY),
                benefitSchemaId: e['benefit']['benefitSchemaId'] ?? 0,
              ),
              hoursPerDayList: e['hoursPerDayList'] == null
                  ? []
                  : (e['hoursPerDayList'] as List).map((hoursPerDayList) {
                      return HoursPerDayListModel(
                          id: hoursPerDayList['id'],
                          hours: hoursPerDayList['hours'], //aqui
                          date: Utils.formatDate(
                              date: hoursPerDayList['date'],
                              format: DateFormatInterface.MM_DD_YY));
                    }).toList(),
            );
          }).toList();

          /*tempEvents.forEach((key, value) {
            tempNameEvents.add(key);
            tempIdEvents.add(value);
          });

          nameEvents = tempNameEvents;
          idEvents = tempIdEvents;*/

          timeOffRequestsList.addAll(newTimeOffRequestsList);

          firsTimeFetch = true;
          loadingTimeOffRequests = false;
          loadingNewTimeOffRequests = false;

          notifyListeners();

          return timeOffRequestsList; //ok
        }
      }
      cancelBottomLoading();
      notifyListeners();
      return [];
    } else {
      cancelBottomLoading();
      notifyListeners();
      return [];
    }
  }

  void expandFilters(int index) {
    // This function is used to expand or collapse the time off request state in filter
    checkboxFilterModelTimeOffRequest[index].isExpanded =
        !checkboxFilterModelTimeOffRequest[index].isExpanded;
    notifyListeners();
  }
}
