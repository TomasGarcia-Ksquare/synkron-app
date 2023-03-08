import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:synkron_app/utils/utils.dart';

import '../../../models/notifications/notification_model.dart';
import '../../../styles/colors_theme.dart';
import '../../../styles/font_styles.dart';

class NotificationsCard extends StatelessWidget {
  const NotificationsCard({
    super.key,
    required this.notificationsData,
    required this.index,
  });

  final List<NotificationModel> notificationsData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: SizedBox(
        height: 60.0,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              notificationsData[index].iconName == 'Timesheet'
                  ? Icon(Icons.today,
                      color: notificationsData[index].isRead == true
                          ? ColorsTheme.textColor
                          : ColorsTheme.primaryBlue,
                      size: 24.0)
                  : SvgPicture.asset(
                      "assets/icons/${notificationsData[index].iconName}.svg",
                      color: notificationsData[index].isRead == true
                          ? ColorsTheme.textColor
                          : ColorsTheme.primaryBlue,
                      width: 24.0,
                      height: 24.0,
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // Used to control notifications description overflow.
                      overflow: TextOverflow.ellipsis,
                      notificationsData.isNotEmpty
                          ? notificationsData[index].description.toString()
                          : 'description',
                      style: notificationsData[index].isRead == true
                          ? TypographyTheme.fontH5
                          : TypographyTheme.fontH5PrimaryBlue,
                    ),
                    Text(
                      notificationsData.isNotEmpty
                          ? Utils.formatDate(
                              date:
                                  notificationsData[index].createdAt.toString(),
                              format: DateFormatInterface.MM_DD_YYY)
                          : 'date',
                      style: TypographyTheme.fontBody2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
