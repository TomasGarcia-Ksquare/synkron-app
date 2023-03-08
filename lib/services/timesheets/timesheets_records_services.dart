import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import '../api/base_api.dart';

class TimeSheetServices with BaseApi {
  /// This function gets the employee timesheets records from the API
  /// using the numberOfPage, where, and orderBy parameters.
  /// It returns a WsResponse object with the success status, message and data of the response.
  Future<WsResponse> getEmployeeTimesheet(
      int numberOfPage, String where, String startDate, String orderBy) async {
    int numberOfRecordsPerPage = 12;
    numberOfPage = numberOfPage * numberOfRecordsPerPage;

    http.Response resp = await executeHttpRequest(
        urlMethod: 'timesheets/self',
        queryParameters: {
          'offset': '$numberOfPage',
          'include':
              '["approver","employee","workShiftList","timesheetAttachment","project"]',
          'where': '{$where}',
          'order': '[["$startDate","$orderBy"]]',
          'limit': '$numberOfRecordsPerPage'
        });

    //'where': '{"status":["rejected","approved"]}',

    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error occurred getting timesheets records');
    }
  }

  /// This function gets the timesheets records of the manager's team  from the API
  /// using the numberOfPage, where, and orderBy parameters.
  /// It returns a WsResponse object with the success status, message and data of the response.
  Future<WsResponse> getMyTeamTimesheet(
      int numberOfPage, String where, String startDate, String orderBy) async {
    int numberOfRecordsPerPage = 12;
    numberOfPage = numberOfPage * numberOfRecordsPerPage;
    
    http.Response resp = await executeHttpRequest(
        urlMethod: 'timesheets/my-team/group/employees',
        queryParameters: {
          'offset': '$numberOfPage',
          'include':
              '["approver","employee","workShiftList","timesheetAttachment","project"]',
          'where': '{$where}',
          'order': '[["$startDate","$orderBy"]]',
          'limit': '$numberOfRecordsPerPage'
        });

    //'where': '{"status":["rejected","approved"]}',

    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error occurred getting timesheets records');
    }
  }
}
