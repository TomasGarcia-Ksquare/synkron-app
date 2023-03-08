import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/auth/auth_provider.dart';
import 'package:synkron_app/providers/navbar/bottom_navbar_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/button/custom_button_widget.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/atoms/snackbar/custom_snackbar.dart';
import 'package:synkron_app/widgets/molecules/login/custom_textfield_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final navigator = Navigator.of(context);
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);
    bottomNavbarProvider.controller = PersistentTabController(initialIndex: 0);
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    TextEditingController _emailCtrl = TextEditingController();
    TextEditingController _passwordCtrl = TextEditingController();

    Future.microtask(
      () {
        if (authProvider.storedToken == true) {
          //print('token');
          authProvider.isLoading = false;
          navigator.popAndPushNamed(
              '/bottomnavbar'); //redirect to '/rute' if user keep log in
        } else {
          //print('no token');
        }
      },
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: ColorsTheme.backgroundBlue,
              ),
            ),
            SvgPicture.asset(
              'assets/images/Background.svg',
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/Login image.png'),
            ),
            authProvider.isLoading
                ? showLoadingInfoWidget()
                : Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Hello,',
                            style: TypographyTheme.fontH2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Welcome to SynKron!',
                              style: TypographyTheme.fontH2PrimaryBlue),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            height: 50,
                            //width: 320,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: ColorsTheme.primaryBlue),
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                informationSnackBar(
                                    scaffoldMessengerState, 'Loading...');
                                Navigator.pushNamed(context, '/auth');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/ms-symbollockup_mssymbol_19.svg'),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Sign in with Microsoft",
                                    style: TypographyTheme.fontBtnPrimaryBlue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //   margin: const EdgeInsets.symmetric(horizontal: 16),
                          //   height: 50,
                          //   width: double.infinity,
                          //   child: CustomButtonWidget(
                          //     text: 'Sign in with credentials',
                          //     onPressed: () =>
                          //         Navigator.pushNamed(context, '/credentials'),
                          //     type: 1,
                          //     icon: Icons.email,
                          //     iconLeft: true,
                          //   ),
                          // ),
                        ]),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
