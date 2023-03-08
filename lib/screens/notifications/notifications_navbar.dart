import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import '../../providers/notifications/notifications_navbar_provider.dart';

class NotificationsNavbar extends StatelessWidget {
  const NotificationsNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationsNavbarProvider =
        Provider.of<NotificationsNavbarProvider>(context);

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: notificationsNavbarProvider.controller,
        screens: notificationsNavbarProvider.buildScreens(context),
        items: notificationsNavbarProvider.navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: ColorsTheme.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: ColorsTheme.primaryBlue,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.linear,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3,
        onItemSelected: (value) {
          notificationsNavbarProvider.onItemSelected(value);
        },
        padding: const NavBarPadding.only(bottom: 11.0),
      ),
    );
  }
}
