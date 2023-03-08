import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/services/api/base_api.dart';

class EmployeeService with BaseApi {
  Future<WsResponse> fetchEmployeeProfileInfo() async {
    http.Response resp = await executeHttpRequest(
        method: HttpMethod.GET,
        urlMethod: "employees/self",
        queryParameters: {"include": '["Region","manager","position"]'});
    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: "An error ocurred while obtaining profile information.");
    }
  }

  Future<WsResponse> fetchEmployeeProjects() async {
    http.Response resp = await executeHttpRequest(
        method: HttpMethod.GET,
        urlMethod: "employees/self/projects",
        queryParameters: {
          'where':
              '{"isActive":true,"projectFilters":{"creationStep":"approved","isGeneral":false}}'
        });
    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message:
              "An error ocurred while obtaining user projects information.");
    }
  }

  Future<WsResponse> fetchEmployeeTimeOffBalance() async {
    http.Response resp = await executeHttpRequest(
      method: HttpMethod.GET,
      urlMethod: "time-off-balance/self",
    );
    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: "An error ocurred while obtaining time-off information.");
    }
  }

  Future<WsResponse> fetchProfileImage(int id) async {
    http.Response resp = await executeHttpRequest(
      method: HttpMethod.GET,
      urlMethod: "file/$id",
    );
    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: "An error ocurred while obtaining profile image.");
    }
  }

  static void checkAndThrowError(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}
