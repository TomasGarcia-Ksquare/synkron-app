import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/molecules/modal/modal_appbar_widget.dart';

import 'package:synkron_app/providers/timesheets/timesheets_records_provider.dart';
import '../../../models/timesheets/timesheet_model.dart';
import '../../../providers/timesheets/timesheet_approvals_provider.dart';
import '../../../providers/timesheets/timesheet_edithours_provider.dart';
import '../../../services/timesheets/timesheet_edit_hours_services.dart';
import '../../atoms/dropdown/dropdown_button.dart';
import '../../atoms/dropdown/dropdown_edit_hours.dart';
import '../../atoms/textFormField/number_textfield.dart';
import '../../molecules/expanded_widget/custom_expanded_panel_widget.dart';
import '../worked_hours/worked_hours_expandables.dart';

class TimesheetEditHoursWidget extends StatefulWidget {
  String workedHours;
  final List<TimesheetModel> myTeam;
  final TimesheetEditHoursProvider providerEditTimesheets;
  final TimesheetApprovalsProvider providerTimesheets;

  TimesheetEditHoursWidget(
      {Key? key,
      required this.workedHours,
      required this.providerEditTimesheets,
      required this.providerTimesheets,
      required this.myTeam})
      : super(key: key);

  @override
  State<TimesheetEditHoursWidget> createState() =>
      _TimesheetEditHoursWidgetState();
}

class _TimesheetEditHoursWidgetState extends State<TimesheetEditHoursWidget> {
  @override
  void initState() {
    // TODO: implement initState
    widget.providerEditTimesheets.fillWorkShiftRecordModel();
    widget.providerEditTimesheets.setWorkedHours(widget.workedHours);
    widget.providerEditTimesheets.actualTimesheet =
        widget.providerEditTimesheets.getActualTimesheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* widget.providerEditTimesheets.getActualTimesheet();
    TimesheetModel _timesheetModel =
        context.watch<TimesheetEditHoursProvider>().actualTimesheet;
    String _workedHours =
        context.watch<TimesheetEditHoursProvider>().workedHours; */
    WorkedHoursExpandables whExpandables = WorkedHoursExpandables(
      workedHours: widget.providerEditTimesheets.workedHours,
      workShiftList: widget.providerEditTimesheets.actualWorkShiftList,
      providerEditTimesheets: widget.providerEditTimesheets,
    );

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(
              Icons.edit,
              color: ColorsTheme.primaryBlue,
              size: 32,
            ),
          ),
          title: Text(
              "Edit Hours - ${widget.providerEditTimesheets.workedHours}",
              style: TypographyTheme.fontH2PrimaryBlue),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomOpacity: 0.0,
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/myteamtimesheets');
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: const Icon(
                  Icons.close,
                  color: ColorsTheme.primaryBlue,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: AnimatedBuilder(
            animation: widget.providerTimesheets,
            builder: (BuildContext context, Widget? child) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownEditHours(
                      items: widget.providerEditTimesheets
                          .getProjectTitles(widget.myTeam),
                      timesheetEditHoursProvider: widget.providerEditTimesheets,
                      providerTimesheets: widget.providerTimesheets,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AnimatedBuilder(
                        animation: widget.providerTimesheets,
                        builder: (BuildContext context, Widget? child) {
                          return whExpandables;
                        }),
                    //whExpandables,
                  ],
                ),
              );
            },
          ),
        ),
        persistentFooterButtons: [
          ExpandedButton(
            onPressed: () {
              if (widget.providerEditTimesheets
                      .isTextFormFieldFilled(whExpandables.getControllers()) &&
                  whExpandables.formGlobalKey.currentState!.validate()) {
                setState(() {
                  List<String> weekArray = whExpandables.getHoursArray();

                  int timesheetId = widget.providerEditTimesheets
                      .actualWorkShiftList[0].timesheetId;
                  TimesheetEditHoursServices().putHoursTimesheets(timesheetId,
                      widget.providerEditTimesheets.actualTimesheet, weekArray);
                  Navigator.popAndPushNamed(context, '/myteamtimesheets');
                });
              }
            },
            bgColor: ColorsTheme.primaryBlue,
            text: 'Submit',
            textStyle: TypographyTheme.fontBtnWhite,
          )
        ]);
  }
}
