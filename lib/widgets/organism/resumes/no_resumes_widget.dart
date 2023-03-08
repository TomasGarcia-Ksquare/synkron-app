import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synkron_app/styles/font_styles.dart';

class NoResumesWidget extends StatelessWidget {
  const NoResumesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          SvgPicture.asset(
            'assets/images/empty-resume.svg',
            width: double.infinity,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          const SizedBox(
            height: 24,
          ),
          const SizedBox(
            child: Text(
              'No Resumes to see yet',
              style: TypographyTheme.fontH2,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            // width: 332,
            width: 255,
            child: Text(
              'Go to your desktop app to create a new Resume!',
              textAlign: TextAlign.center,
              style: TypographyTheme.fontBody1,
            ),
          ),
        ],
      ),
    );
  }
}
