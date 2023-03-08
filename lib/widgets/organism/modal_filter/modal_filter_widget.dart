import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/molecules/checkbox_filter/checkbox_filter_widget.dart';
import 'package:synkron_app/widgets/molecules/modal/modal_appbar_widget.dart';

class TimesheetFilterWidget extends StatefulWidget {
  var providerTimesheets;
  TimesheetFilterWidget({Key? key, required this.providerTimesheets})
      : super(key: key);

  @override
  State<TimesheetFilterWidget> createState() => _TimesheetFilterWidgetState();
}

class _TimesheetFilterWidgetState extends State<TimesheetFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ModalAppbarWidget(
            appBar: AppBar(), title: 'Filters', icon: Icons.filter_alt),
        body: SingleChildScrollView(
          child: AnimatedBuilder(
            animation: widget.providerTimesheets,
            builder: (BuildContext context, Widget? child) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: widget.providerTimesheets,
                      builder: (BuildContext context, Widget? child) {
                        return CheckboxFilter(
                          checkboxFilters: widget
                              .providerTimesheets.checkboxFilterModelTimesheets,
                          expansionCallback: (index) {
                            widget.providerTimesheets.expandFilters(index);
                          },
                          providerTimesheets: widget.providerTimesheets,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        persistentFooterButtons: [
          SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                ExpandedButton(
                  onPressed: () {
                    setState(() {
                      widget.providerTimesheets.clearFiltersValues();
                    });
                  },
                  bgColor: ColorsTheme.white,
                  text: 'Clear Filters',
                  textStyle: TypographyTheme.fontBtnPrimaryBlue,
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpandedButton(
                  onPressed: () {
                    widget.providerTimesheets.resetTimesheetRecord();
                    widget.providerTimesheets.applyFilter = true;   
                    Navigator.pop(context);
                  },
                  bgColor: ColorsTheme.primaryBlue,
                  text: 'Apply',
                  textStyle: TypographyTheme.fontBtnWhite,
                )
              ],
            ),
          )
        ]);
  }
}
