import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/navbar/bottom_navbar_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/molecules/floating_action_button/custom_menu_floating_action_button_widget.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: bottomNavbarProvider.controller,
        screens: bottomNavbarProvider.buildScreens(context),
        items: bottomNavbarProvider.navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: ColorsTheme.primaryBlue,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: ColorsTheme.white,
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
          bottomNavbarProvider.onItemSelected(value);
        },
      ),
      floatingActionButton: bottomNavbarProvider.isFab
          ? const Padding(
              padding: EdgeInsets.only(bottom: 58),
              child: CustomMenuFloatingActionButton(),
            )
          : null,
    );
  }
}
