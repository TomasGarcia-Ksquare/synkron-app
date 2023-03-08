import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_request_provider.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_validators_controller.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/textFormField/custom_text_form_field.dart';
import 'package:synkron_app/widgets/molecules/text/richtext_two_styles.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({super.key});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  @override
  Widget build(BuildContext context) {
    var timeOffProvider =
        Provider.of<TimeOffRequestProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichtextTwoStyles(
            text1: 'Comments ',
            style1: TypographyTheme.fontH2AccentBlue2,
            text2: '(Optional)',
            style2: TypographyTheme.fontH2Placeholder,
          ),
          const SizedBox(height: 24),
          CustomTextFormField(
            hintText: 'Comment (max 250 characters)',
            ctrl: timeOffProvider.commentsCtrl,
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            verticalPadding: 16,
            enabled: timeOffProvider.enableTextformfields,
            validation: TimeOffValidatorsController().commentsValidator,
          )
        ],
      ),
    );
  }
}
