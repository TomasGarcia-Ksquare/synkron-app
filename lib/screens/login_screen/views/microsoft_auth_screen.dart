import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/auth/auth_provider.dart';
import 'package:synkron_app/providers/navbar/bottom_navbar_provider.dart';
import 'package:synkron_app/utils/constants.dart';
import 'package:synkron_app/widgets/atoms/snackbar/custom_snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MicrosoftAuthScreen extends StatelessWidget {
  MicrosoftAuthScreen({super.key});
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    final microsoftAuthProvider = Provider.of<AuthProvider>(context);
    final navigator = Navigator.of(context);
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl: constants.endpointUrl + constants.microsoftAuth,
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (String url) async {
            if (url.startsWith(constants.tokenUrl)) {
              var temporalToken = url.split("=")[1];
              isAuth =
                  await microsoftAuthProvider.getAccessToken(temporalToken);
              if (isAuth) {
                successSnackBar(
                    scaffoldMessengerState, 'Loged in successfully');
                bottomNavbarProvider.isFab = true;
                navigator.pushNamedAndRemoveUntil(
                  '/bottomnavbar', //redirect to '/rute' if user loged in successfully
                  (Route<dynamic> route) => false,
                );
              }
            }
          },
        ),
      ),
    );
  }
}
