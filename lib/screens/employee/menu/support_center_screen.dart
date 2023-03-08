import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/molecules/app_bar/custom_app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SupportCenterScreen extends StatelessWidget {
  const SupportCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
            title: 'Support Center',
            textStyle: TypographyTheme.fontH2AccentBlue2),
        body: const WebView(
          initialUrl:
              'https://forms.office.com/pages/responsepage.aspx?id=taRN5PPc10CaMIXefO_UasQFdfX4km9Nj0-kQfreXJVUQjM2QlpHM0tOWTU2VktTSThFVExCNEpLMy4u&sid=19c00b56-eb5d-4261-91c0-4231b05d9766',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
