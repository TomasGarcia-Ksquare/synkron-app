import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:synkron_app/models/resume_model.dart';
import 'package:synkron_app/providers/resumes/resumes_provider.dart';
import 'package:synkron_app/services/permission_handle/permission_handle_service.dart';
import 'package:synkron_app/services/resumes/resume_file_service.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
// import 'package:synkron_app/ui/screens/resumes/widgets/pdf_viewer_widget.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/atoms/pdf_file/pdf_viewer_widget.dart';

class ResumeCard extends StatefulWidget {
  const ResumeCard({
    super.key,
    required this.resume,
  });

  final Resume resume;

  @override
  State<ResumeCard> createState() => _ResumeCardState();
}

class _ResumeCardState extends State<ResumeCard> {
  ResumesProvider resumesProvider = ResumesProvider();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.resume.resumeData!.resumeTitle}',
            style: TypographyTheme.fontBtn,
          ),
          const SizedBox(height: 6),
          Text(
            // 'Updated:\n$updatedDate',
            'Updated:\n${resumesProvider.formatUpdatedDate(widget.resume.updatedAt.toString())}',
            style: TypographyTheme.fontBody2,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: PDF(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
                ..add(
                  Factory<TapGestureRecognizer>(
                    () => TapGestureRecognizer()
                      ..onTapDown = (tab) {
                        showGeneralDialog(
                            context: context,
                            pageBuilder: (BuildContext buildContext,
                                Animation animation,
                                Animation secondaryAnimation) {
                              return SafeArea(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    right: 16,
                                    left: 16,
                                    bottom: 24,
                                  ),
                                  child: Column(
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          return Container(
                                            padding: EdgeInsets.zero,
                                            width: double.infinity,
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 13),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 13),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                100,
                                        child: PdfViewer(
                                          url: widget.resume.resumeFile!.url
                                              .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                  ),
                ),
              swipeHorizontal: true,
            ).cachedFromUrl(
              widget.resume.resumeFile!.url.toString(),
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),
          ),
          const SizedBox(height: 16),
          ExpandedButton(
              text: 'Download',
              textStyle: TypographyTheme.fontBtnWhite,
              bgColor: ColorsTheme.primaryBlue,
              onPressed: () async {
                var file = widget.resume.resumeFile!;
                await PermissionHandleService().checkPermission();
                ResumeFileService().createDownloadTask(file.downloadUrl!);
              }),
          // const SizedBox(height: 24),
        ],
      ),
    );
  }
}
