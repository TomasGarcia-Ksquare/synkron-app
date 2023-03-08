// ignore_for_file: constant_identifier_names

import 'package:http/http.dart' as http;
import 'package:synkron_app/services/auth/auth_service.dart';
import 'dart:convert' as json;
import '../../main.dart';

mixin BaseApi {
  /// Executes an HTTP request based on the specified parameters
  ///
  /// urlMethod: the url method to execute
  /// method: the HTTP method to use, defaults to GET
  /// body: the body of the request, defaults to null
  /// queryParameters: query parameters to add to the request
  /// apiToken: an API token to use, defaults to an empty string
  Future<http.Response> executeHttpRequest(
      {required String urlMethod,
      String method = HttpMethod.GET,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      String apiToken = ''}) async {
    final AuthService authServices = AuthService();
    String token =
        apiToken.isNotEmpty ? apiToken : await authServices.getToken();
    var uri = Uri.parse(env!['SYNRKON_API_URL'] as String);
    uri = uri.replace(
        path: '/api/v1/$urlMethod', queryParameters: queryParameters);
    switch (method) {
      case HttpMethod.DELETE:
        return http.delete(
          uri,
          headers: _getHeader(token),
        );
      case HttpMethod.POST:
        return http.post(
          uri,
          body: body == null ? null : json.jsonEncode(body),
          headers: _getHeader(token),
        );
      case HttpMethod.PUT:
        return http.put(
          uri,
          body: body == null ? null : json.jsonEncode(body),
          headers: _getHeader(token),
        );
      default:
        return http.get(
          uri,
          headers: _getHeader(token),
        );
    }
  }

  /// Returns a header with the specified token
  Map<String, String> _getHeader(String token) {
    return {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
}

class HttpMethod {
  static const String PUT = 'PUT';
  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String DELETE = 'DELETE';
}
