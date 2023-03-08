import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/resumes/resumes_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/molecules/app_bar/custom_app_bar_widget.dart';
import 'package:synkron_app/widgets/organism/resumes/no_resumes_widget.dart';
import 'package:synkron_app/widgets/organism/resumes/with_resumes_widget.dart';

class ResumesScreen extends StatefulWidget {
  const ResumesScreen({super.key});

  @override
  State<ResumesScreen> createState() => _ResumesScreenState();
}

class _ResumesScreenState extends State<ResumesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ResumesProvider>(context, listen: false).loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsShadesTheme.neutralGray1,
        appBar: customAppBar(
            title: 'Resumes', textStyle: TypographyTheme.fontH2AccentBlue2),
        body: Center(
          child: Consumer<ResumesProvider>(
            builder: (context, provider, child) {
              if (provider.loadingResumes == true) {
                return showLoadingInfoWidget();
              }
              if (provider.resumesList.isNotEmpty) {
                return const WithResumesWidget();
              }
              return const NoResumesWidget();
            },
          ),
        ),
      ),
    );
  }
}
