import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_model.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

class UserColumnInfo extends StatelessWidget {
  final EmployeeProfileModel user;
  const UserColumnInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 125.0),
        Text(user.fullName!, style: TypographyTheme.fontH4),
        const SizedBox(height: 4.0),
        Text(user.region!.name!, style: TypographyTheme.fontSub1),
        const SizedBox(height: 4.0),
        if (user.position!.name != "" && user.position!.name != null)
          Text(user.position!.name!, style: TypographyTheme.fontSub1),
        const SizedBox(height: 4.0),
        if (user.hiringDate != "" && user.hiringDate != null)
          Text("Hiring date: ${user.hiringDate!}",
              style: TypographyTheme.fontBody2),
        const SizedBox(height: 4.0),
        if (user.phone != "N/A")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.phone, color: ColorsTheme.primaryPressedBlue),
              const SizedBox(width: 4.0),
              Text(user.phone!, style: TypographyTheme.fontBody2),
            ],
          ),
        const SizedBox(height: 4.0),
        if (user.jobEmail != "" && user.jobEmail != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.mail, color: ColorsTheme.primaryPressedBlue),
              const SizedBox(width: 4.0),
              Text(user.jobEmail!, style: TypographyTheme.fontBody2),
            ],
          ),
      ],
    );
  }
}
