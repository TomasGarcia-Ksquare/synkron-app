import 'package:flutter/material.dart';
import 'package:synkron_app/models/filter_model/checkbox_filter.dart';
import 'package:synkron_app/widgets/molecules/expanded_widget/custom_expanded_panel_widget.dart';
import '../../../../../../styles/colors_theme.dart';

class CheckboxFilter extends StatefulWidget {
  final List<CheckboxFilterModel> checkboxFilters;
  final Function expansionCallback;
  var providerTimesheets;

  CheckboxFilter(
      {Key? key,
      required this.checkboxFilters,
      required this.expansionCallback,
      required this.providerTimesheets})
      : super(key: key);

  @override
  State<CheckboxFilter> createState() => _CheckboxFilterState();
}

class _CheckboxFilterState extends State<CheckboxFilter> {
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
                          .providerTimesheets
                          .checkboxFilterModelTimesheets[
                              widget.checkboxFilters.indexOf(e)]
                          .optionsValuesTemp[e.options.indexOf(d)],
                      onChanged: ((newValue) {
                        setState(() {
                          widget.providerTimesheets.changeOptionsValuesTemp(
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
