import 'package:flutter/material.dart';
import 'package:synkron_app/screens/employee/menu/global_calendar_screen.dart';
import 'package:synkron_app/screens/employee/menu/support_center_screen.dart';
import 'package:synkron_app/screens/employee/menu/synkron_manual_screen.dart';
import 'package:synkron_app/screens/employee/time_off/create_timeoff_request_screen.dart';
import 'package:synkron_app/screens/employee/time_off/timeoff_screen.dart';
import 'package:synkron_app/screens/employee/timesheets/new_timesheet.dart';
import 'package:synkron_app/screens/login_screen/views/credentials_auth_screen.dart';
import 'package:synkron_app/screens/login_screen/views/login_screen.dart';
import 'package:synkron_app/screens/login_screen/views/microsoft_auth_screen.dart';
import 'package:synkron_app/screens/notifications/notifications_navbar.dart';
import 'package:synkron_app/screens/resumes/views/resumes_screen.dart';
import 'package:synkron_app/widgets/layout/bottom_navbar.dart';
import '../screens/manager/timeoff/requests/manager_timeoff_screen.dart';
import '../screens/manager/timesheets/approvals/manager_timesheets_view_phone.dart';
import '../screens/notifications/notifications_mine.dart';
import '../screens/notifications/notifications_team.dart';
import '../screens/employee/timesheets/records/employee_timesheets_view_phone.dart';
import '../screens/home/home_screen.dart';

class RouteGenerator {
  var generateRoute = ((settings) {
    var routeName = settings.name;

    switch (routeName) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case '/auth':
        return MaterialPageRoute(
          builder: (context) => MicrosoftAuthScreen(),
        );
      case '/employetimesheetsrecords':
        return MaterialPageRoute(
            builder: (context) => EmployeeTimesheet(navContext: context));
      case '/myteamtimesheets':
        return MaterialPageRoute(
            builder: (context) => MyTeamTimesheet(navContext: context));
      case '/resumes':
        return MaterialPageRoute(
          builder: (context) => const ResumesScreen(),
        );
      case '/bottomnavbar':
        return MaterialPageRoute(builder: (context) => const BottomNavbar());
      case '/globalcalendar':
        return MaterialPageRoute(
          builder: (context) => const GlobalCalendarScreen(),
        );
      // Added route for my notifications navbar file.
      case '/notificationsnavbar':
        return MaterialPageRoute(
          builder: (context) => const NotificationsNavbar(),
        );
      // Added route for my notifications screen.
      case '/notificationsmine':
        return MaterialPageRoute(
          builder: (context) => const MyNotificationScreen(),
        );
      // Added route for my team notifications screen.
      case '/notificationsteam':
        return MaterialPageRoute(
          builder: (context) => const TeamNotificationScreen(),
        );
      case '/timeoff':
        return MaterialPageRoute(
            builder: (context) => TimeOffScreen(
                  navContext: context,
                ));
      case '/myteamtimeoff':
        return MaterialPageRoute(
          builder: (context) => TimeOffManagerScreen(
            navContext: context,
          ),
        );
      case '/create-request':
        return MaterialPageRoute(
            builder: (context) => const CreateTimeOffRequestScreen());
      case '/supportcenter':
        return MaterialPageRoute(
          builder: (context) => SupportCenterScreen(),
        );
      case '/synkronmanual':
        return MaterialPageRoute(
          builder: (context) => SynkronManualScreen(),
        );
      case '/newtimesheet':
        return MaterialPageRoute(
          builder: (context) => const NewTimeSheet(),
        );
      case '/credentials':
        return MaterialPageRoute(
          builder: (context) => const CredentialsAuthScreen(),
        );
    }
    return null;
  });
}
