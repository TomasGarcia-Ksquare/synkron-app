import 'package:flutter/material.dart';

import '../../../styles/colors_theme.dart';
import '../../../styles/font_styles.dart';
import '../../atoms/button/custom_close_notification_button.dart';
import '../../atoms/button/custom_mark_as_read_notifications_button.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({
    super.key,
    this.isManager,
    this.notificationsNavBarContext,
  });

  final bool? isManager;
  final BuildContext? notificationsNavBarContext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.notifications,
          size: 22.0,
          color: ColorsTheme.accentBlue2,
        ),
        Text(
          'Notifications',
          style: TypographyTheme.fontH2AccentBlue2,
        ),
        const SizedBox(
          width: 80.0,
        ),
        isManager!
            ? const SizedBox(
                width: 8.0,
              )
            : const CustomMarkAsReadButton(),
        CustomCloseNotificationButton(
          isManager: isManager!,
          notificationsNavBarContext: notificationsNavBarContext ?? context,
          context: context,
        ),
      ],
    );
  }
}
