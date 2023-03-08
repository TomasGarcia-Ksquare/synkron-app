import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/button/custom_notification_button_widget.dart';

import '../../../providers/navbar/bottom_navbar_provider.dart';

class UserWelcomeHeader extends StatelessWidget {
  final String firstName;
  const UserWelcomeHeader(
      {super.key, required this.firstName, this.navBarContext});

  final BuildContext? navBarContext;

  @override
  Widget build(BuildContext context) {
    final bool? isManager =
        Provider.of<BottomNavbarProvider>(context).isManager;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Welcome, $firstName!",
            style: TypographyTheme.fontH3AccentBlue,
          ),
          CustomNotificationButtonWidget(
              screenManager: '/notificationsnavbar',
              screenEmployee: '/notificationsmine',
              isManager: isManager!,
              navBarContext: navBarContext!),
        ],
      ),
    );
  }
}
