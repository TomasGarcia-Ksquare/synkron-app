import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/molecules/modal/modal_appbar_widget.dart';

class TimeOffFilterSortWidget extends StatefulWidget {
  var providerTimeOffRecords;
  TimeOffFilterSortWidget({Key? key, required this.providerTimeOffRecords})
      : super(key: key);

  @override
  State<TimeOffFilterSortWidget> createState() =>
      _TimeOffFilterSortWidgetState();
}

class _TimeOffFilterSortWidgetState extends State<TimeOffFilterSortWidget> {
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
              groupValue: widget.providerTimeOffRecords.orderByIndexTemp,
              onChanged: (value) {
                setState(() {
                  widget.providerTimeOffRecords.orderByIndexTemp = value;
                });
              },
            ),
            RadioListTile(
              title: const Text("Oldest Date"),
              value: 1,
              groupValue: widget.providerTimeOffRecords.orderByIndexTemp,
              onChanged: (value) {
                setState(() {
                  widget.providerTimeOffRecords.orderByIndexTemp = value;
                });
              },
            ),
            RadioListTile(
              title: const Text("Last Modified"),
              value: 2,
              groupValue: widget.providerTimeOffRecords.orderByIndexTemp,
              onChanged: (value) {
                setState(() {
                  widget.providerTimeOffRecords.orderByIndexTemp = value;
                });
              },
            )
          ],
        ),
        persistentFooterButtons: [
          ExpandedButton(
            onPressed: () {
              setState(() {
                widget.providerTimeOffRecords.pageOffset = 0;
                widget.providerTimeOffRecords.resetTimeOffRequest();

                widget.providerTimeOffRecords.getTimeOffRecords(
                    widget.providerTimeOffRecords.pageOffset,
                    employee: true);
                Navigator.pop(context);
              });
            },
            bgColor: ColorsTheme.primaryBlue,
            text: 'Apply',
            textStyle: TypographyTheme.fontBtnWhite,
          )
        ]);
  }
}
