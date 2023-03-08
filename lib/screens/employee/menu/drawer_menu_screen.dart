import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/auth/auth_provider.dart';
import 'package:synkron_app/providers/navbar/drawer_menu_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/atoms/divider/horizontal_divider_widget.dart';
import 'package:synkron_app/widgets/atoms/snackbar/custom_snackbar.dart';
import 'package:synkron_app/widgets/molecules/menu_option_widget/menu_option_widget.dart';

class DrawerMenuScreen extends StatelessWidget {
  BuildContext navContext;

  DrawerMenuScreen({
    Key? key,
    required this.navContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(navContext, '/resumes');
                },
                child: MenuOptionWidget(text: 'Resumes'),
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
              const Expanded(child: SizedBox()),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
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
      ),
    );
  }
}
