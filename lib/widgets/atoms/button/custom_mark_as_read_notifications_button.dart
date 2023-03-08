import 'package:flutter/material.dart';

import '../../../services/notifications/notification_services.dart';
import '../../../styles/colors_theme.dart';

class CustomMarkAsReadButton extends StatelessWidget {
  const CustomMarkAsReadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        NotificationServices().getEmployeeNotificationsRead();
      },
      icon: const Icon(
        Icons.mark_email_read_outlined,
        color: ColorsTheme.primaryBlue,
        size: 32.0,
      ),
    );
  }
}
