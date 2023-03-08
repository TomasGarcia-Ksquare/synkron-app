import 'package:flutter/material.dart';

import '../../../models/timesheets/timesheet_model.dart';
import '../../../providers/timesheets/timesheet_approvals_provider.dart';
import '../../../providers/timesheets/timesheet_edithours_provider.dart';
import '../../../styles/colors_theme.dart';
import '../../molecules/modal/custom_bottom_modal.dart';
import '../../molecules/modal/modal_canva_widget.dart';
import '../../organism/modal_edit_hours/modal_edit_hours.dart';

class DropdownEditHours extends StatefulWidget {
  final List<String> items;
  final TimesheetEditHoursProvider timesheetEditHoursProvider;
  final TimesheetApprovalsProvider providerTimesheets;

  DropdownEditHours(
      {super.key,
      required this.items,
      required this.timesheetEditHoursProvider,
      required this.providerTimesheets});
  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<DropdownEditHours> {
  late String dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.timesheetEditHoursProvider.isEmptyProjectName()) {
      dropdownValue = widget.items[0];
    } else {
      dropdownValue = widget.timesheetEditHoursProvider.actualProjectName;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Padding(
          padding: const EdgeInsets.only(left: 110.0),
          child: Icon(Icons.arrow_drop_down, color: ColorsTheme.primaryBlue),
        ),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: ColorsTheme.textColor,
        ),
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            widget.timesheetEditHoursProvider.setProjectName(dropdownValue);
            widget.timesheetEditHoursProvider
                .setMyTeam(widget.timesheetEditHoursProvider.myTeam);

            CustomBottomModal().customShowModalBottomSheet(
                context,
                ModalCanvaWidget(
                  widget: TimesheetEditHoursWidget(
                    workedHours: widget.timesheetEditHoursProvider.workedHours,
                    providerTimesheets: widget.providerTimesheets,
                    providerEditTimesheets: widget.timesheetEditHoursProvider,
                    myTeam: widget.timesheetEditHoursProvider.myTeam,
                  ),
                ));
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
