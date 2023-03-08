import 'package:flutter/cupertino.dart';
import 'package:synkron_app/services/notifications/notification_services.dart';
import '../../models/notifications/notification_model.dart';
import '../../models/util/ws_rensponse_model.dart';

class NotificationsProvider with ChangeNotifier {
  bool isLoading = false;

  // Initialize the Notification Services.
  final NotificationServices notificationServices = NotificationServices();

  // Initialize the notification list with an empty list
  List<NotificationModel> notificationsRecord = [];

  // Function to get notifications records from the api.
  Future<void> getNotificationsRecords() async {
    isLoading = true;
    notifyListeners();

    // Clear the notificationsRecord list
    notificationsRecord = [];
    // Get the notifications records from the api
    WsResponse wsResponse =
        await notificationServices.getEmployeeNotifications();
    // If the api call was successful
    if (wsResponse.success) {
      // Get the data from the api response
      dynamic bodyResponse = wsResponse.data;
      // If there is no data in the response
      if (bodyResponse == null) {
        return;
      }
      // Get the notification record list from the response data
      List data = bodyResponse['data']['notifications'];
      // Map the notification record list to the NotificationModel
      notificationsRecord = data
          .map<NotificationModel>((e) => NotificationModel(
                id: e['notification']['id'],
                description: e['notification']['description'],
                type: e['notification']['type'],
                subtype: e['notification']['subtype'],
                requiresAction: e['notification']['requiresAction'],
                isRead: e['notification']['isRead'],
                iconName: e['notification']['iconName'],
                employeeId: e['notification']['employeeId'],
                createdAt: DateTime.parse(e['notification']['createdAt']),
              ))
          .toList();

      isLoading = false;
      notifyListeners();
    }
  }

  // Method to get the notifications record from another screen.
  get getNotificationData => notificationsRecord;
}
