import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../styles/colors_theme.dart';

class CustomCloseNotificationButton extends StatelessWidget {
  const CustomCloseNotificationButton(
      {super.key,
      required this.isManager,
      required this.notificationsNavBarContext,
      required this.context});

  final bool isManager;
  final BuildContext notificationsNavBarContext;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (() {
        isManager
            ? Navigator.pop(notificationsNavBarContext)
            : Navigator.pop(context);
      }),
      icon: const Icon(
        Icons.close,
        color: ColorsTheme.primaryBlue,
        size: 32.0,
      ),
    );
  }
}
