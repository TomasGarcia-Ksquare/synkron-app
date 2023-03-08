import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_model.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/avatar/profile_avatar_image.dart';
import 'package:synkron_app/widgets/molecules/text/richtext_two_styles.dart';

class ManagerInfo extends StatelessWidget {
  final EmployeeProfileModel manager;
  const ManagerInfo({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatarImage(
          imagePath: manager.imagePath.toString(),
          radius: 24,
        ),
        const SizedBox(width: 16),
        RichtextTwoStyles(
          text1: 'Sending to\n ',
          style1: TypographyTheme.fontBody1,
          text2: manager.fullName,
          style2: TypographyTheme.fontSub1,
        ),
      ],
    );
  }
}
