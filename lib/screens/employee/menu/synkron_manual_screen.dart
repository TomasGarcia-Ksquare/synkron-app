import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/molecules/app_bar/custom_app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SynkronManualScreen extends StatelessWidget {
  const SynkronManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
            title: 'Synkron Manual',
            textStyle: TypographyTheme.fontH2AccentBlue2),
        body: const WebView(
          initialUrl:
              'https://ksquaregroup-my.sharepoint.com/personal/elda_urtecho_theksquaregroup_com/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Felda%5Furtecho%5Ftheksquaregroup%5Fcom%2FDocuments%2FEmployee%20Portal%2FDocuments%2FShared%20Edited%2FPublished%20Manuals%2FSynkron%20Employee%20Onboarding%2Epdf&parent=%2Fpersonal%2Felda%5Furtecho%5Ftheksquaregroup%5Fcom%2FDocuments%2FEmployee%20Portal%2FDocuments%2FShared%20Edited%2FPublished%20Manuals&ga=1',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
