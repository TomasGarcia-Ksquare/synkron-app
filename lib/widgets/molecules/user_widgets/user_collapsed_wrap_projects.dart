import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_project_model.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

class UserCollapsedWrapProjects extends StatelessWidget {
  final List<EmployeeProjectModel> projects;
  const UserCollapsedWrapProjects({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      children: <Widget>[
        for (var i = 0; i < 4; i++)
          if (projects.length > i)
            Chip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                backgroundColor: ColorsTheme.white,
                label: Text(projects[i].projectPosition!.project!.name!,
                    style: TypographyTheme.fontSub1,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
