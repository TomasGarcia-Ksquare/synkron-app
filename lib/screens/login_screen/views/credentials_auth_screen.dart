import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/auth/auth_provider.dart';
import 'package:synkron_app/providers/navbar/bottom_navbar_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/atoms/button/custom_button_widget.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/atoms/snackbar/custom_snackbar.dart';
import 'package:synkron_app/widgets/molecules/app_bar/custom_app_bar_widget.dart';
import 'package:synkron_app/widgets/molecules/login/custom_textfield_widget.dart';

class CredentialsAuthScreen extends StatelessWidget {
  const CredentialsAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final navigator = Navigator.of(context);
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);
    bottomNavbarProvider.controller = PersistentTabController(initialIndex: 0);
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    TextEditingController _emailCtrl = TextEditingController();
    TextEditingController _passwordCtrl = TextEditingController();
    bool isAuth = false;

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
              fit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/Login image.png'),
            ),
            authProvider.isLoading
                ? Scaffold(
                    body: showLoadingInfoWidget(),
                    backgroundColor: Colors.transparent,
                  )
                : Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: customAppBar(title: 'Sign in with credentials'),
                    body: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomTextFieldWidget(
                              hint: 'Email',
                              controller: _emailCtrl,
                              password: false,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomTextFieldWidget(
                              hint: 'Password',
                              controller: _passwordCtrl,
                              password: true,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomButtonWidget(
                              text: 'Sign in',
                              onPressed: () async {
                                isAuth = await authProvider.emailAuth(
                                    _emailCtrl.text, _passwordCtrl.text);
                                if (isAuth) {
                                  successSnackBar(scaffoldMessengerState,
                                      'Loged in successfully');
                                  bottomNavbarProvider.isFab = true;
                                  navigator.pushNamedAndRemoveUntil(
                                    '/bottomnavbar', //redirect to '/rute' if user loged in successfully
                                    (Route<dynamic> route) => false,
                                  );
                                } else {
                                  errorSnackBar(
                                      scaffoldMessengerState, 'Error');
                                }
                              },
                              type: 1,
                              icon: Icons.email,
                              iconLeft: true,
                            ),
                          ),
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
