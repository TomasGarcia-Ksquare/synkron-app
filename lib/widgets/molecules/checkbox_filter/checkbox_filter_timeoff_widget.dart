import 'package:flutter/material.dart';
import 'package:synkron_app/models/filter_model/checkbox_filter.dart';
import 'package:synkron_app/widgets/molecules/expanded_widget/custom_expanded_panel_widget.dart';
import '../../../../../../styles/colors_theme.dart';

class TimeOffCheckboxFilter extends StatefulWidget {
  final List<CheckboxFilterModel> checkboxFilters;
  final Function expansionCallback;
  var providerTimeOffRecords;

  TimeOffCheckboxFilter(
      {Key? key,
      required this.checkboxFilters,
      required this.expansionCallback,
      required this.providerTimeOffRecords})
      : super(key: key);

  @override
  State<TimeOffCheckboxFilter> createState() => _TimeOffCheckboxFilterState();
}

class _TimeOffCheckboxFilterState extends State<TimeOffCheckboxFilter> {
  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        widget.expansionCallback(index);
      },
      children: widget.checkboxFilters.map((e) {
        return CustomExpansionPanel(
          backgroundColor: ColorsTheme.backgroundBlue,
          isExpanded: e.isExpanded,
          canTapOnHeader: false,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(e.filterTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: ColorsTheme.accentBlue2,
                    fontFamily: 'Nunito-Sans',
                  )),
            );
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: e.options.map((d) {
              return Row(
                children: [
                  Checkbox(
                      value: widget
                          .providerTimeOffRecords
                          .checkboxFilterModelTimeOffRequest[
                              widget.checkboxFilters.indexOf(e)]
                          .optionsValuesTemp[e.options.indexOf(d)],
                      onChanged: ((newValue) {
                        setState(() {
                          widget.providerTimeOffRecords.changeOptionsValuesTemp(
                              widget.checkboxFilters.indexOf(e),
                              e.options.indexOf(d),
                              newValue!);
                        });
                      })),
                  Text(d),
                ],
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
