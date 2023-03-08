import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/util/ws_rensponse_model.dart';
import 'api/base_api.dart';


class ActiveProjectsServices with BaseApi {

  //Method to get all active projects of the employee
  Future<WsResponse> getActiveProjects() async {
    http.Response resp = await executeHttpRequest(
        urlMethod: 'employees/self/projects',
        queryParameters: {
          'where': '{"isActive":true}',
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
