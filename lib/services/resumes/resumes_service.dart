import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/services/api/base_api.dart';

class ResumesService with BaseApi {
  getOwnResumes() async {
    http.Response resp = await executeHttpRequest(urlMethod: 'resumes/self');
    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false, message: 'An error occurred getting the resumes');
    }
  }

  getResumeFile(int id) async {
    http.Response resp = await executeHttpRequest(
      urlMethod: 'file/$id',
    );
    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
        success: false,
        message: 'An error occurred getting the resume file',
      );
    }
  }
}
