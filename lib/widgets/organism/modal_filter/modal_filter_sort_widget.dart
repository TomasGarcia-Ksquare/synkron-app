import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/molecules/modal/modal_appbar_widget.dart';

class TimesheetFilterSortWidget extends StatefulWidget {
  var providerTimesheets;
  TimesheetFilterSortWidget({Key? key, required this.providerTimesheets})
      : super(key: key);

  @override
  State<TimesheetFilterSortWidget> createState() =>
      _TimesheetFilterSortWidgetState();
}

class _TimesheetFilterSortWidgetState extends State<TimesheetFilterSortWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ModalAppbarWidget(
            appBar: AppBar(), title: 'Sort by', icon: Icons.sort),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            RadioListTile(
              title: const Text("Latest Date"),
              value: 0,
              groupValue: widget.providerTimesheets.orderByIndexTemp,
              onChanged: (value) {
                setState(() {
                  widget.providerTimesheets.orderByIndexTemp = value;
                });
              },
            ),
            RadioListTile(
              title: const Text("Oldest Date"),
              value: 1,
              groupValue: widget.providerTimesheets.orderByIndexTemp,
              onChanged: (value) {
                setState(() {
                  widget.providerTimesheets.orderByIndexTemp = value;
                });
              },
            ),
            RadioListTile(
              title: const Text("Last Modified"),
              value: 2,
              groupValue: widget.providerTimesheets.orderByIndexTemp,
              onChanged: (value) {
                setState(() {
                  widget.providerTimesheets.orderByIndexTemp = value;
                });
              },
            )
          ],
        ),
        persistentFooterButtons: [
          ExpandedButton(
            onPressed: () {
               widget.providerTimesheets.resetTimesheetRecord();
                    widget.providerTimesheets.applySort = true;   
                    Navigator.pop(context);
            },
            bgColor: ColorsTheme.primaryBlue,
            text: 'Apply',
            textStyle: TypographyTheme.fontBtnWhite,
          )
        ]);
  }
}
