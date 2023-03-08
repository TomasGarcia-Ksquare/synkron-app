import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/molecules/app_bar/custom_app_bar_widget.dart';

class GlobalCalendarScreen extends StatelessWidget {
  const GlobalCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Global Calendar',
          textStyle: TypographyTheme.fontH2AccentBlue2),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: InteractiveViewer(
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
                child: Image.network(
              'https://devportal.theksquaregroup.com/static/media/Calendar.560eff86.png',
              fit: BoxFit.contain,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                return child;
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: showLoadingInfoWidget(),
                  );
                }
              },
            )),
          ),
        ),
      ),
    );
  }
}
