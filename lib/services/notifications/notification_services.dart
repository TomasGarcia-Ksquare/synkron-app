import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/util/ws_rensponse_model.dart';
import '../api/base_api.dart';

class NotificationServices with BaseApi {
  /// This function gets the employees notifications from the API
  /// It returns a WsResponse object with the success status, message and data of the response.

  Future<WsResponse> getEmployeeNotifications() async {
    http.Response resp = await executeHttpRequest(
        urlMethod: 'employees/self/notifications',
        queryParameters: {
          'where': '{"requiresAction":false}',
          'order': '[["createdAt","DESC"]]',
        });
    try {
      dynamic respJson = jsonDecode(resp.body);
      return WsResponse(
        success: true,
        data: respJson,
      );
    } catch (e) {
      return WsResponse(
        success: false,
        message: 'An error ocurred getting notifications.',
      );
    }
  }

  /// This function puts all the employees notifications as read.
  Future<void> getEmployeeNotificationsRead() async {
    await executeHttpRequest(
      method: HttpMethod.PUT,
      urlMethod: 'employees/self/notifications/MarkAllAsRead',
    );
  }

  /// This functions returns the team's notifications from the API.
  Future<WsResponse> getTeamsNotifications() async {
    http.Response resp = await executeHttpRequest(
        urlMethod: 'employees/self/notifications',
        queryParameters: {
          'where': '{"requiresAction":true}',
          'order': '[["createdAt","DESC"]]',
        });
    try {
      dynamic respJson = jsonDecode(resp.body);
      return WsResponse(
        success: true,
        data: respJson,
      );
    } catch (e) {
      return WsResponse(
        success: false,
        message: 'An error ocurred getting notifications.',
      );
    }
  }

  getNotificationsCount() async {
    http.Response resp = await executeHttpRequest(
      urlMethod: 'employees/self/notifications',
    );
    try {
      dynamic respJson = jsonDecode(resp.body);
      var number = respJson['data']['timeOffRequestsCount'] +
          respJson['data']['timeSheetsRequestsCount'] +
          respJson['data']['resumesCount'] +
          respJson['data']['newTeamMembersCount'] +
          respJson['data']['missingTimesheetsCount'];
      return number;
    } catch (e) {
      return 0;
    }
  }
}
