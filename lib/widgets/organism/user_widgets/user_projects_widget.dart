import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_project_model.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/molecules/user_widgets/user_collapsed_wrap_projects.dart';
import 'package:synkron_app/widgets/molecules/user_widgets/user_wrap_projects.dart';

class UserProjectWidget extends StatelessWidget {
  final List<EmployeeProjectModel> projects;
  const UserProjectWidget({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: ColorsShadesTheme.neutralGray1),
      child: ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ScrollOnExpand(
            scrollOnExpand: true,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  iconSize: 24,
                  iconColor: ColorsTheme.primaryHoverBlue2),
              header: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Projects",
                      style: TypographyTheme.fontH4AccentBlue2)),
              collapsed: UserCollapsedWrapProjects(projects: projects),
              expanded: UserWrapProjects(projects: projects),
              builder: (_, collapsed, expanded) {
                return Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
