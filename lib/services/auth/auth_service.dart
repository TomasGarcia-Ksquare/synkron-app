import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/services/api/base_api.dart';
import 'package:synkron_app/utils/constants.dart';

class AuthService with BaseApi {
  Constants constants = Constants();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  /*Future<WsResponse> exchangeTemporalToken(temporalToken) async {
    print('service: exchangeTemporalToken');
    http.Response response = await executeHttpRequest(
      urlMethod: constants.authExchangeToken,
      method: HttpMethod.POST,
      body: {'Authorization': 'Bearer $temporalToken'},
    );
    try {
      print('exchangeTemporalToken: ' + jsonDecode(response.body));
      return WsResponse(success: true, data: jsonDecode(response.body));
    } catch (e) {
      return WsResponse(
          success: false,
          message: 'An error occurred exchanging temporal token');
    }
  }*/

  Future exchangeTemporalToken(temporalToken) async {
    String url = constants.endpointUrl + constants.authExchangeToken;
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.post(
        uri,
        headers: {'Authorization': 'Bearer $temporalToken'},
      );
      var responseJson = jsonDecode(response.body);
      return responseJson;
    } catch (e) {
      print(e);
    }
  }

  /*Future<WsResponse> validateToken(accessToken) async {
    http.Response response = await executeHttpRequest(
      urlMethod: constants.authValidateToken,
      method: HttpMethod.GET,
      body: {'Authorization': 'Bearer $accessToken'},
    );
    try {
      return WsResponse(success: true, data: jsonDecode(response.body));
    } catch (e) {
      return WsResponse(
          success: false, message: 'An error occurred verfying access token');
    }
  }*/

  Future validateToken(accessToken) async {
    String url =
        'https://dev-portalapi.theksquaregroup.com/api/v1/auth/validate-token';
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      var responseJson = jsonDecode(response.body);
      return responseJson;
    } catch (e) {
      print(e);
    }
  }

  Future<String> getToken() async {
    try {
      String? token = await storage.read(key: 'token');
      return token!;
    } catch (e) {
      return '';
    }
  }

  Future<void> setToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }

  Future emailLogin(email, password) async {
    http.Response response = await executeHttpRequest(
      urlMethod: 'emailauth/login',
      method: HttpMethod.POST,
      body: {"email": email, "password": password},
    );
    try {
      return WsResponse(success: true, data: jsonDecode(response.body));
    } catch (e) {
      return WsResponse(success: false, message: 'emailLogin() error');
    }
  }
}
