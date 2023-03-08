import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/auth/auth_provider.dart';
import 'package:synkron_app/providers/navbar/bottom_navbar_provider.dart';
import 'package:synkron_app/providers/notifications/notifications_provider.dart';
import 'package:synkron_app/providers/employee/employee_provider.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_request_provider.dart';
import 'package:synkron_app/providers/resumes/resumes_provider.dart';
import 'package:synkron_app/providers/timesheets/timesheet_approvals_provider.dart';
import 'package:synkron_app/providers/timesheets/timesheet_edithours_provider.dart';
import 'package:synkron_app/providers/timesheets/timesheets_records_provider.dart';
import 'package:synkron_app/providers/upload_image/upload_image_provider.dart';
import 'package:synkron_app/routes/router_generator.dart';
import 'package:synkron_app/styles/colors_theme.dart';

import 'providers/notifications/notifications_navbar_provider.dart';
import 'utils/env.dart';

Map<String, String>? env;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  //Load the environment variables
  env = await loadEnvFile('assets/env/.env');
  // Run the app with the providers
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => EmployeeProvider()),
    ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
    ChangeNotifierProvider(create: (_) => NotificationsNavbarProvider()),
    ChangeNotifierProvider(create: (_) => TimesheetsProvider()),
    ChangeNotifierProvider(create: (_) => TimesheetApprovalsProvider()),
    ChangeNotifierProvider(create: (_) => TimesheetEditHoursProvider()),
    ChangeNotifierProvider(
      create: (BuildContext context) => ResumesProvider(),
    ),
    // Adding NotificationsProvider to the main file.
    ChangeNotifierProvider(create: (_) => NotificationsProvider()),
    ChangeNotifierProvider(
      create: (context) => TimeOffRequestProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UploadImageProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synkron App',
      theme: ThemeData(
        primaryColor: ColorsTheme.primaryBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/login",
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
