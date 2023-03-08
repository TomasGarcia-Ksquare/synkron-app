import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/navbar/bottom_navbar_provider.dart';
import 'package:synkron_app/screens/employee/time_off/create_timeoff_request_screen.dart';
import 'package:synkron_app/screens/employee/timesheets/new_timesheet.dart';
import 'package:synkron_app/styles/colors_theme.dart';

class CustomMenuFloatingActionButton extends StatelessWidget {
  const CustomMenuFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);

    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: ColorsTheme.primaryBlue,
      overlayColor: const Color.fromARGB(5, 0, 0, 0),
      overlayOpacity: 0.2,
      childrenButtonSize: const Size(55, 50),
      spaceBetweenChildren: 12,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.access_time_filled),
            backgroundColor: ColorsTheme.primaryBlue,
            foregroundColor: ColorsTheme.white,
            labelWidget: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: ColorsTheme.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Text('Request time off'),
            ),
            onTap: () {
              pushNewScreenWithRouteSettings(
                context,
                settings: const RouteSettings(name: '/create-request'),
                screen: const CreateTimeOffRequestScreen(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            }),
        SpeedDialChild(
          onTap: () {
            pushNewScreenWithRouteSettings(context,
                screen: const NewTimeSheet(),
                settings: const RouteSettings(name: '/newtimesheet'),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
          child: const Icon(Icons.edit_note),
          backgroundColor: ColorsTheme.primaryBlue,
          foregroundColor: ColorsTheme.white,
          labelWidget: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: ColorsTheme.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Text('Submit timesheet'),
          ),
        ),
        bottomNavbarProvider.vacationsDays
            ? SpeedDialChild(
                child: const Icon(Icons.beach_access),
                backgroundColor: ColorsTheme.primaryBlue,
                foregroundColor: ColorsTheme.white,
                labelWidget: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: ColorsTheme.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text('Request vacations'),
                ),
              )
            : SpeedDialChild()
      ],
      onOpen: () => bottomNavbarProvider.allowVacationsDays(),
    );
  }
}
