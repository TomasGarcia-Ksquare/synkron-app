import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/models/resume_model.dart';
import 'package:synkron_app/providers/resumes/resumes_provider.dart';
import 'package:synkron_app/services/resumes/resume_file_service.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/molecules/resumes/resume_card_widget.dart';

class WithResumesWidget extends StatefulWidget {
  const WithResumesWidget({super.key});

  @override
  State<WithResumesWidget> createState() => _WithResumesWidgetState();
}

class _WithResumesWidgetState extends State<WithResumesWidget> {
  @override
  void initState() {
    super.initState();
    ResumeFileService().setupPort();
  }

  @override
  void dispose() {
    ResumeFileService().removePortMappping();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<ResumesProvider>(
            builder: (context, provider, child) {
              if (provider.resumesList.isNotEmpty) {
                List<Resume> resumeList = provider.resumesList;
                return ListView.builder(
                  itemCount: resumeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Resume resume = resumeList[index];
                    return ResumeCard(
                      resume: resume,
                    );
                  },
                );
              }
              return showLoadingInfoWidget();
            },
          ),
        ),
        const SizedBox(
          height: 24,
        )
      ],
    );
  }
}
