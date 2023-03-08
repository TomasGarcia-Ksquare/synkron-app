import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/util/ws_rensponse_model.dart';
import '../api/base_api.dart';

class TimesheetApprovalsServices with BaseApi {
  /// This function gets the user's team timesheets records from the API
  /// using the numberOfPage, where, and orderBy parameters.
  /// It returns a WsResponse object with the success status, message and data of the response.
  Future<WsResponse> getUserTeamTimesheets(
      int numberOfPage, String startDate, String orderBy) async {
    http.Response resp = await executeHttpRequest(
        urlMethod: 'timesheets/my-team/group/employees',
        queryParameters: {
          'offset': '$numberOfPage',
          'include': '["Project","employee","workShiftList"]',
          'where': '{"status":{"\$eq":"pending"}}',
          'order': '[["$startDate","$orderBy"]]',
        });

    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error occurred getting timesheets records');
    }
  }

  Future<WsResponse> putStatusTeamTimesheets(int id, String status) async {
    http.Response resp = await executeHttpRequest(
        method: HttpMethod.PUT,
        urlMethod: 'timesheets/my-team/$id',
        body: {
          'status': status
        });

    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error occurred getting timesheets records');
    }
  }

}
