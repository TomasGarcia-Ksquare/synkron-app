import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/auth/auth_provider.dart';
import 'package:synkron_app/providers/navbar/drawer_menu_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/atoms/divider/horizontal_divider_widget.dart';
import 'package:synkron_app/widgets/atoms/menu/expansion_menu_option_widget.dart';
import 'package:synkron_app/widgets/atoms/snackbar/custom_snackbar.dart';
import 'package:synkron_app/widgets/molecules/menu_option_widget/menu_option_widget.dart';

class DrawerMenuManagerScreen extends StatelessWidget {
  BuildContext navContext;

  DrawerMenuManagerScreen({
    Key? key,
    required this.navContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(navContext, '/resumes');
                    },
                    child: MenuOptionWidget(text: 'Resumes'),
                  ),
                  const HorizontalDividerWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ConfigurableExpansionTile(
                      animatedWidgetFollowingHeader: const Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorsTheme.primaryBlue,
                      ),
                      header: Text(
                        'My Team',
                        style: TypographyTheme.fontH5PrimaryBlue,
                      ),
                      childrenBody: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    navContext, '/myteamtimesheets');
                              },
                              child: const ExpansionMenuOptionWidget(
                                  title: 'Timesheets')),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    navContext, '/myteamtimeoff');
                              },
                              child: const ExpansionMenuOptionWidget(
                                  title: 'Time Off')),
                          //const ExpansionMenuOptionWidget(title: 'Time Off'),
                          //const ExpansionMenuOptionWidget(title: 'Resumes'),
                        ],
                      ),
                    ),
                  ),
                  const HorizontalDividerWidget(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(navContext, '/synkronmanual');
                    },
                    child: MenuOptionWidget(text: 'Synkron Manual'),
                  ),
                  const HorizontalDividerWidget(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(navContext, '/globalcalendar');
                    },
                    child: MenuOptionWidget(text: 'Global Calendar'),
                  ),
                  const HorizontalDividerWidget(),
                  GestureDetector(
                    onTap: () {
                      //informationSnackBar(scaffoldMessengerState, 'Loading...');
                      Navigator.pushNamed(navContext, '/supportcenter');
                    },
                    child: MenuOptionWidget(text: 'Support Center'),
                  ),
                ],
              ),
            ),
          ),
          persistentFooterButtons: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 40,
              width: double.infinity,
              child: ExpandedButton(
                text: 'Logout',
                textStyle: TypographyTheme.fontBtnPrimaryBlue,
                bgColor: ColorsTheme.white,
                borderColor: ColorsTheme.primaryBlue,
                onPressed: () async {
                  await DrawerMenuProvider()
                      .logout(); //delete tokens in local storage
                  authProvider.storedToken =
                      false; //set false to storedToken variable
                  successSnackBar(scaffoldMessengerState,
                      'Loged out successfully'); //notification
                  Navigator.pushNamedAndRemoveUntil(
                    navContext,
                    '/login',
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
