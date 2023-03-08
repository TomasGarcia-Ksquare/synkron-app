import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/molecules/modal/modal_appbar_widget.dart';

import '../../molecules/checkbox_filter/checkbox_filter_timeoff_widget.dart';

class TimeOffFilterWidget extends StatefulWidget {
  var providerTimeOffRecords; //manager or employee
  TimeOffFilterWidget({Key? key, required this.providerTimeOffRecords})
      : super(key: key);

  @override
  State<TimeOffFilterWidget> createState() => _TimeOffFilterWidgetState();
}

class _TimeOffFilterWidgetState extends State<TimeOffFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ModalAppbarWidget(
            appBar: AppBar(), title: 'Filters', icon: Icons.filter_alt),
        body: SingleChildScrollView(
          child: AnimatedBuilder(
            animation: widget.providerTimeOffRecords,
            builder: (BuildContext context, Widget? child) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: widget.providerTimeOffRecords,
                      builder: (BuildContext context, Widget? child) {
                        return TimeOffCheckboxFilter(
                          checkboxFilters: widget.providerTimeOffRecords
                              .checkboxFilterModelTimeOffRequest,
                          expansionCallback: (index) {
                            widget.providerTimeOffRecords.expandFilters(index);
                          },
                          providerTimeOffRecords: widget.providerTimeOffRecords,
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
                      widget.providerTimeOffRecords.clearFiltersValues();
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
                    widget.providerTimeOffRecords.resetTimeOffRequest();

                    widget.providerTimeOffRecords.getTimeOffRecords(
                        widget.providerTimeOffRecords.pageOffset,
                        employee: true);
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
