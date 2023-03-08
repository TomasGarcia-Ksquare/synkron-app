
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/util/ws_rensponse_model.dart';
import '../api/base_api.dart';

class TimeOffRecordsEmployeeServices with BaseApi {
  Future<WsResponse> getTimeOffRecordsEmployee(
      int numberOfPage, String where, String startDate, String orderBy) async {
    int numberOfRecordsPerPage = 3;
    numberOfPage = numberOfPage * numberOfRecordsPerPage;

    http.Response resp = await executeHttpRequest(
        urlMethod: 'time-off-requests/self',
        queryParameters: {
          'offset': '$numberOfPage',
          'limit': '$numberOfRecordsPerPage', //99
          'include': '["benefit","TimeOffAttachment","hoursPerDayList"]',
          'order': '[["$startDate","$orderBy"]]',
          'where': '{$where}',
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
