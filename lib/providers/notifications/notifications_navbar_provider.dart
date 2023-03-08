import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:synkron_app/routes/router_generator.dart';
import 'package:synkron_app/screens/notifications/notifications_mine.dart';
import 'package:synkron_app/screens/notifications/notifications_team.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import '../../models/notifications/notification_model.dart';
import '../../models/util/ws_rensponse_model.dart';
import '../../services/notifications/notification_services.dart';

class NotificationsNavbarProvider extends ChangeNotifier {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(null),
        title: ("Mine"),
        textStyle: TypographyTheme.fontH2,
        activeColorPrimary: ColorsTheme.primaryBlue,
        inactiveColorSecondary: ColorsTheme.primaryBlue,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: RouteGenerator().generateRoute,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(null),
        title: ("My team's"),
        textStyle: TypographyTheme.fontH2,
        activeColorPrimary: ColorsTheme.primaryBlue,
        inactiveColorSecondary: ColorsTheme.primaryBlue,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: RouteGenerator().generateRoute,
        ),
      ),
    ];
  }

  List<Widget> buildScreens(context) {
    return [
      MyNotificationScreen(
        notificationsNavBarContext: context,
      ),
      TeamNotificationScreen(
        notificationsNavBarContext: context,
      ),
    ];
  }

  onItemSelected(int value) async {
    if (value == 1) {
      await getTeamNotificationsRecords();
    }
  }

  bool isLoading = false;

  // Initialize the notification list from my team with an empty list
  List<NotificationModel> teamNotificationsRecord = [];
  final NotificationServices notificationServices = NotificationServices();

  Future<void> getTeamNotificationsRecords() async {
    isLoading = true;
    notifyListeners();

    // Clear the teamNotificationsRecord list
    teamNotificationsRecord = [];
    // Get the team's notifications records from the api
    WsResponse wsResponse = await notificationServices.getTeamsNotifications();
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
      teamNotificationsRecord = data
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

  // Method to get the team's notifications record from another screen.
  get getTeamNotificationData => teamNotificationsRecord;
}
