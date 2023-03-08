import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/routes/router_generator.dart';
import 'package:synkron_app/screens/home/home_screen.dart';
import 'package:synkron_app/screens/employee/menu/drawer_menu_screen.dart';
import 'package:synkron_app/screens/employee/time_off/timeoff_screen.dart';
import 'package:synkron_app/screens/manager/menu/drawer_menu_manager_screen.dart';
import 'package:synkron_app/services/employee/employee_service.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

import '../../screens/employee/timesheets/records/employee_timesheets_view_phone.dart';

class BottomNavbarProvider extends ChangeNotifier {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  bool isFab = true;
  bool? isManager = false;
  var storage = const FlutterSecureStorage();
  bool isLoading = false;
  bool vacationsDays = false;

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        textStyle: TypographyTheme.fontBody3,
        activeColorPrimary: ColorsTheme.white,
        inactiveColorSecondary: ColorsTheme.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: RouteGenerator().generateRoute,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.edit_note),
        title: ("Timesheets"),
        textStyle: TypographyTheme.fontBody3,
        activeColorPrimary: ColorsTheme.white,
        inactiveColorSecondary: ColorsTheme.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: RouteGenerator().generateRoute,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.access_time_filled),
        title: ("Time Off"),
        textStyle: TypographyTheme.fontBody3,
        activeColorPrimary: ColorsTheme.white,
        inactiveColorSecondary: ColorsTheme.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: RouteGenerator().generateRoute,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu),
        title: ("Menu"),
        textStyle: TypographyTheme.fontBody3,
        activeColorPrimary: ColorsTheme.white,
        inactiveColorSecondary: ColorsTheme.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: RouteGenerator().generateRoute,
        ),
      ),
    ];
  }

  List<Widget> buildScreens(context) {
    return [
      HomeScreen(
        navBarContext: context,
      ),
      EmployeeTimesheet(navContext: context),
      TimeOffScreen(navContext: context),
      isManager!
          ? DrawerMenuManagerScreen(navContext: context)
          : DrawerMenuScreen(navContext: context),
    ];
  }

  onItemSelected(int value) async {
    if (value == 3) {
      //menu screen selected
      isFab = false;
      notifyListeners();
    } else {
      isFab = true;
      notifyListeners();
    }
  }

  allowVacationsDays() async {
    print('fab');
    WsResponse wsResponse =
        await EmployeeService().fetchEmployeeTimeOffBalance();
    dynamic resp = wsResponse.data;
    List<EmployeeTimeOffModel> data = [];
    for (var element in resp["data"]) {
      if (element["availableHours"] > 0 &&
          element['requestedHours'] < element['availableHours']) {
        data.add(EmployeeTimeOffModel.fromJson(element));
      }
    }
    List<EmployeeTimeOffModel> timeOffAvailable = data;
    timeOffAvailable.forEach((element) {
      if (element.displayName == 'Vacations Days') {
        vacationsDays = true;
        notifyListeners();
      }
    });
  }
}
