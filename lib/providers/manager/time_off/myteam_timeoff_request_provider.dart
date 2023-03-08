import 'dart:core';
import 'package:flutter/cupertino.dart';
import '../../../models/time_off/manager/myteam_timeoff_requests_model.dart';
import '../../../models/util/ws_rensponse_model.dart';
import '../../../services/time_off/manager_timeoff_request_services.dart';
import '../../../utils/utils.dart';

class TimeOffRequestsMyTeamProvider extends ChangeNotifier {
  // Initialize the service
  final timeOffRequestsMyTeamService = TimeOffRequestsMyTeamServices();

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
  List<TimeOffRequestsModel> timeOffRequestsList = [];

  // Initialize the loading status variables with true
  bool loadingTimeOffRequestInfo = true;
  bool loadingTimeOffRequests = true;
  bool loadingNewTimeOffRequests = true;

  //Total number of time off records
  num recordsNum = 0;

  /* METHODS */

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

  //Method to set the value of the "loadingNewTimeOffRequests" variable to false (to indicate that the animation of loading new time off records should no longer be continued)
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

  // Function to get time off records from the api
  Future<List<TimeOffRequestsModel>> getMyTeamTimeOffRequests(int numberOfPage,
      {bool employee = false}) async {
    if (isLastPage == false) {
      loadingNewTimeOffRequests = true;
      notifyListeners();

      // Clear the time off request list
      List<TimeOffRequestsModel> newTimeOffRequestsList = [];

      // Get the time off records from the api
      WsResponse wsResponse = await timeOffRequestsMyTeamService
          .getTimeOffRequestsMyTeam(numberOfPage);

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

          newTimeOffRequestsList = data.map((e) {
            return TimeOffRequestsModel(
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
                id: e['benefit']['id'],
                name: e['benefit']['name'],
                displayName: e['benefit']['displayName'],
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
              employee: EmployeeModel(
                id: e['employee']['id'],
                fullName: e['employee']['fullName'],
                departmentId: e['employee']['departmentId'],
                isDepartmentManager: e['employee']['isDepartmentManager'],
                managerId: e['employee']['managerId'],
                workingHours: e['employee']['workingHours'],
                status: e['employee']['status'],
                externalId: e['employee']['externalId'],
                updatedById: e['employee']['updatedById'],
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
          timeOffRequestsList.addAll(newTimeOffRequestsList);

          firsTimeFetch = true;
          loadingTimeOffRequests = false;
          loadingNewTimeOffRequests = false;

          notifyListeners();

          return timeOffRequestsList;
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

  void setStatus(TimeOffRequestsModel timeoff, String state) {
    // Set status to a time off
    timeOffRequestsMyTeamService.putStatusTeamTimeOff(timeoff.id, state);
    ChangeNotifier();
  }
}
