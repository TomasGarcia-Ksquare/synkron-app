import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/notifications/notifications_navbar_provider.dart';
import 'package:synkron_app/widgets/atoms/button/custom_scroll_to_top_floating_action_button.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/molecules/notifications_card/notifications_card.dart';
import 'package:synkron_app/widgets/molecules/notifications_header/notifications_header_widget.dart';
import '../../models/notifications/notification_model.dart';
import '../../providers/navbar/bottom_navbar_provider.dart';
import '../../styles/colors_theme.dart';

class TeamNotificationScreen extends StatelessWidget {
  const TeamNotificationScreen({
    super.key,
    this.notificationsNavBarContext,
  });

  final BuildContext? notificationsNavBarContext;

  @override
  Widget build(BuildContext context) {
    List<NotificationModel> notificationsData =
        context.watch<NotificationsNavbarProvider>().getTeamNotificationData;
    ScrollController scrollController = ScrollController();
    final bool? isManager =
        Provider.of<BottomNavbarProvider>(context).isManager;
    final NotificationsNavbarProvider notificationProvider =
        Provider.of<NotificationsNavbarProvider>(context);

    return Scaffold(
      floatingActionButton: CustomScrollToTopFAB(
        heroTag: 'TeamNotifications',
        scrollController: scrollController,
      ),
      backgroundColor: ColorsTheme.backgroundBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 32.0,
            ),
            NotificationsHeader(
              isManager: isManager,
              notificationsNavBarContext: notificationsNavBarContext,
            ),
            const SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: 650,
              width: double.infinity,
              child: notificationProvider.isLoading == false
                  ? ListView.builder(
                      controller: scrollController,
                      itemCount: notificationsData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationsCard(
                            notificationsData: notificationsData, index: index);
                      })
                  : showLoadingInfoWidget(),
            )
          ]),
        ),
      ),
    );
  }
}
