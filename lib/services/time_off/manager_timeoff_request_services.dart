import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/util/ws_rensponse_model.dart';
import '../api/base_api.dart';

class TimeOffRequestsMyTeamServices with BaseApi {
  Future<WsResponse> getTimeOffRequestsMyTeam(int numberOfPage) async {
    int numberOffRequestPerPage = 3;
    numberOfPage = numberOfPage * numberOffRequestPerPage;
    http.Response resp = await executeHttpRequest(
        urlMethod: 'time-off-requests/my-team',
        queryParameters: {
          'offset': '$numberOfPage',
          'limit': '$numberOffRequestPerPage',
          'include':
              '["benefit","employee","TimeOffAttachment","hoursPerDayList"]',
          'order': '[["createdAt","DESC"]]',
          'where':
              '{"state": {"\$eq": "requested"}, "startDate": {"\$gte": "1999-12-31T06:00:00.000Z"}}',
        });

    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error occurred getting timesheets records');
    }
  }

  Future<WsResponse> putStatusTeamTimeOff(int id, String state) async {
    http.Response resp = await executeHttpRequest(
        method: HttpMethod.PUT,
        urlMethod: 'time-off-requests/my-team/$id',
        body: {'state': state});

    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error occurred getting timesheets records');
    }
  }
}
