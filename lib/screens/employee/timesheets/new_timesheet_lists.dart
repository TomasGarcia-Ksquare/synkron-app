import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/molecules/expanded_widget/custom_expanded_panel_widget.dart';

List week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
int index = 0;
bool isExpanded = false;

class NewTimeSheetLists extends StatelessWidget {
  int index;
  NewTimeSheetLists({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
        expansionCallback: (index, isExpanded) {
          // expansionCallback(index);
        }, //week[index].list((e) =>

        children: [
          CustomExpansionPanel(
            isExpanded: false,
            backgroundColor: ColorsTheme.backgroundBlue,
            canTapOnHeader: false,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: isExpanded ? Text(week[index]) : Text(week[index]),
              );
            },
            body: Container(),
          )
        ]);
  }
}
