import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';
/*
Note that in order to use this widget, you will need to have a Scaffold widget with a 
ScaffoldMessenger widget in your widget tree. You can access the ScaffoldMessengerState 
object using the ScaffoldMessenger.of(context) method.
*/

class CustomSnackbar {
  static void showSnackBar({
    required ScaffoldMessengerState scaffoldMessengerState,
    TextStyle? textStyle,
    required String myMessage,
    int myDuration = 5,
    IconData? myIcon,
    Color? myIconColor,
  }) {
    final SnackBar snackbar = SnackBar(
      content: myIcon != null
          ? Row(
              children: [
                Icon(color: myIconColor, myIcon),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  myMessage,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  myMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
      duration: Duration(seconds: myDuration),
      behavior: SnackBarBehavior.floating,
    );
    scaffoldMessengerState
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}

void successSnackBar(
    ScaffoldMessengerState scaffoldMessengerState, String message) {
  CustomSnackbar.showSnackBar(
    scaffoldMessengerState: scaffoldMessengerState,
    myMessage: message,
    myIcon: Icons.check_circle,
    myIconColor: Colors.green,
  );
}

void errorSnackBar(
    ScaffoldMessengerState scaffoldMessengerState, String message) {
  CustomSnackbar.showSnackBar(
    scaffoldMessengerState: scaffoldMessengerState,
    myMessage: message,
    myIcon: Icons.error,
    myIconColor: ColorsTheme.destructiveRed,
  );
}

void warningSnackBar(
    ScaffoldMessengerState scaffoldMessengerState, String message) {
  CustomSnackbar.showSnackBar(
    scaffoldMessengerState: scaffoldMessengerState,
    myMessage: message,
    myIcon: Icons.warning,
    myIconColor: ColorsTheme.accentYellow,
  );
}

void informationSnackBar(
    ScaffoldMessengerState scaffoldMessengerState, String message) {
  CustomSnackbar.showSnackBar(
    scaffoldMessengerState: scaffoldMessengerState,
    myMessage: message,
    myIcon: Icons.info,
    myIconColor: ColorsTheme.primaryBlue,
  );
}
