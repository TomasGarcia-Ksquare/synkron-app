import 'package:flutter/material.dart';

import '../../../models/timesheets/timesheet_model.dart';
import '../../../providers/timesheets/timesheet_approvals_provider.dart';
import '../../../providers/timesheets/timesheet_edithours_provider.dart';
import '../../../styles/colors_theme.dart';
import '../../../styles/font_styles.dart';
import '../../atoms/textFormField/number_textfield.dart';
import '../../molecules/expanded_widget/custom_expanded_panel_widget.dart';

class WorkedHoursExpandables extends StatelessWidget {
  final TimesheetEditHoursProvider providerEditTimesheets;
  final String workedHours;
  final List<WorkShiftModel> workShiftList;
  late TextEditingController _mondayCtrl;
  late TextEditingController _tuesdayCtrl;
  late TextEditingController _xdayCtrl;
  late TextEditingController _thursdayCtrl;
  late TextEditingController _fridayCtrl;
  late final Map<String, TextEditingController> controllers;
  WorkedHoursExpandables(
      {super.key,
      required this.workedHours,
      required this.providerEditTimesheets,
      required this.workShiftList});
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _mondayCtrl = TextEditingController();
    _tuesdayCtrl = TextEditingController();
    _xdayCtrl = TextEditingController();
    _thursdayCtrl = TextEditingController();
    _fridayCtrl = TextEditingController();

    controllers = {
      'Monday': _mondayCtrl,
      'Tuesday': _tuesdayCtrl,
      'Wednesday': _xdayCtrl,
      'Thursday': _thursdayCtrl,
      'Friday': _fridayCtrl
    };
    if (workedHours.isNotEmpty) {
      List<String> hours = providerEditTimesheets.getOrderedHours();
      controllers.forEach((key, value) {
        value.text = hours[getDayIndex(key)];
      });
    }

    return Form(
      key: formGlobalKey,
      child: AnimatedBuilder(
        animation: providerEditTimesheets,
        builder: (BuildContext context, Widget? child) {
          return CustomExpansionPanelList(
            expansionCallback: (index, isExpanded) {
              providerEditTimesheets.expandNumberTextfield(index);
            },
            children: providerEditTimesheets.workShiftRecordModel
                .map((e) => CustomExpansionPanel(
                    backgroundColor: ColorsTheme.backgroundBlue,
                    isExpanded: e.isExpanded,
                    canTapOnHeader: false,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(e.day,
                            style: const TextStyle(
                              fontSize: 16,
                              color: ColorsTheme.accentBlue2,
                              fontFamily: 'Nunito-Sans',
                            )),
                      );
                    },
                    body: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        CustomNumberField(
                          controller: controllers[e.day]!,
                          labelText: "Hours",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    )))
                .toList(),
          );
        },
      ),
    );
  }

  int getDayIndex(String day) {
    switch (day) {
      case 'Monday':
        return 0;
      case 'Tuesday':
        return 1;
      case 'Wednesday':
        return 2;
      case 'Thursday':
        return 3;
      case 'Friday':
        return 4;
      default:
        return -1;
    }
  }

  List<String> getHoursArray() {
    List<String> hours = [];
    controllers.forEach((key, value) {
      hours.add(value.text);
    });
    return hours;
  }

  Map<String, TextEditingController> getControllers() {
    return controllers;
  }
}
