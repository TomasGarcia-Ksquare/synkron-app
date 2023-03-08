import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/notifications/notifications_provider.dart';

import '../../../services/notifications/notification_services.dart';
import '../../../styles/colors_theme.dart';

class CustomNotificationButtonWidget extends StatelessWidget {
  const CustomNotificationButtonWidget({
    Key? key,
    required this.screenManager,
    required this.screenEmployee,
    required this.isManager,
    required this.navBarContext,
  }) : super(key: key);

  final String screenManager;
  final String screenEmployee;
  final bool isManager;
  final BuildContext navBarContext;

  @override
  Widget build(BuildContext context) {
    final NotificationsProvider notProv =
        Provider.of<NotificationsProvider>(context);
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: ColorsTheme.primaryBlue),
      child: IconButton(
          color: ColorsTheme.white,
          onPressed: (() async {
            var numbers = await NotificationServices().getNotificationsCount();
            isManager
                ? Navigator.pushNamed(navBarContext, screenManager)
                : Navigator.pushNamed(navBarContext, screenEmployee);
          }),
          icon: const Icon(
            Icons.notifications,
            size: 24,
          )),
    );
  }
}
