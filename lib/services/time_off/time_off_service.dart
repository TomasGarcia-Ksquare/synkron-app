import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/services/api/base_api.dart';

class TimeOffService with BaseApi {
  Future<WsResponse> createTimeOffRequest(body) async {
    http.Response resp = await executeHttpRequest(
      urlMethod: 'time-off-requests/self',
      method: HttpMethod.POST,
      body: body,
    );
    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error ocurred while creating time off request');
    }
  }

  //generate a post request to the server to attach the id from image to an id from time off
  Future<WsResponse> attachImageToTimeOffRequest(body) async {
    http.Response resp = await executeHttpRequest(
      urlMethod: 'timeoffattachment',
      method: HttpMethod.POST,
      body: body,
    );
    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message:
              'An error ocurred while attaching image to time off request');
    }
  }
}
