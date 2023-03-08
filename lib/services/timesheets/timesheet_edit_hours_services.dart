import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/timesheets/timesheet_model.dart';
import '../../models/util/ws_rensponse_model.dart';
import '../api/base_api.dart';

class TimesheetEditHoursServices with BaseApi {
 
  /// This function update the hours of a given team timesheets record 
  /// using the timesheetId, the timesheet to be edited, and the hours array.
  /// It returns a WsResponse object with the success status, message and data of the response.
  Future<WsResponse> putHoursTimesheets(
      int timesheetId, TimesheetModel timesheetModel, List<String> week) async {
    timesheetModel = updateTimeSheet(timesheetModel, week);
    List<int> hours = getIntHours(week);
    http.Response resp = await executeHttpRequest(
        method: HttpMethod.PUT,
        urlMethod: 'timesheets/my-team/$timesheetId',
        body: {
          'id': '$timesheetId',
          'status': timesheetModel.status,
          'projectId': timesheetModel.projectModel.id,
          'workShiftList': [
            {
              'date': timesheetModel.workShiftList[0].date,
              'id': timesheetModel.workShiftList[0].id,
              'hours': hours[0]
            },
            {
              'date': timesheetModel.workShiftList[1].date,
              'id': timesheetModel.workShiftList[1].id,
              'hours': hours[1]
            },
            {
              'date': timesheetModel.workShiftList[2].date,
              'id': timesheetModel.workShiftList[2].id,
              'hours': hours[2]
            },
            {
              'date': timesheetModel.workShiftList[3].date,
              'id': timesheetModel.workShiftList[3].id,
              'hours': hours[3]
            },
            {
              'date': timesheetModel.workShiftList[4].date,
              'id': timesheetModel.workShiftList[4].id,
              'hours': hours[4]
            },
            {
              'date': timesheetModel.workShiftList[5].date,
              'id': timesheetModel.workShiftList[5].id,
              'hours': 0
            },
            {
              'date': timesheetModel.workShiftList[6].date,
              'id': timesheetModel.workShiftList[6].id,
              'hours': 0
            },
          ]
        });

    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error occurred editting hours in timesheets approvals');
    }
  }

  // Orders the workshiflist by date and then assign the corresponding hour
  TimesheetModel updateTimeSheet(
      TimesheetModel timesheetModel, List<String> week) {
    timesheetModel.workShiftList.sort((a, b) => a.date.compareTo(b.date));
    for (int i = 0; i < 5; i++) {
      timesheetModel.workShiftList[i].hours = week[i];
    }
    return timesheetModel;
  }

  // Returns an int array because the API structure needs hours to be an int
  List<int> getIntHours(List<String> week) {
    List<int> hours = [];
    week.forEach((element) {
      hours.add(int.parse(element));
    });
    return hours;
  }
  /* Future<WsResponse> putStatusTeamTimesheets(int id, String status) async {
    http.Response resp = await executeHttpRequest(
        method: HttpMethod.PUT,
        urlMethod: 'timesheets/my-team/$id',
        body: {'status': status});

    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error occurred getting timesheets records');
    }
  } */
}
