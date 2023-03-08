import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_project_model.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

class UserWrapProjects extends StatelessWidget {
  final List<EmployeeProjectModel> projects;
  const UserWrapProjects({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      children: <Widget>[
        for (var i in projects)
          Chip(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              backgroundColor: ColorsTheme.white,
              label: Text(i.projectPosition!.project!.name!,
                  style: TypographyTheme.fontSub1,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
