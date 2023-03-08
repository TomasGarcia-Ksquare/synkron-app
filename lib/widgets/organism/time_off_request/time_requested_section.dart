import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_hours_controller.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_request_provider.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_validators_controller.dart';
import 'package:synkron_app/widgets/atoms/textFormField/custom_text_form_field.dart';
import 'package:synkron_app/widgets/molecules/text/title_and_description.dart';

class TimeRequestedSection extends StatefulWidget {
  final FocusNode? myFocusNode;
  const TimeRequestedSection({
    super.key,
    this.myFocusNode,
  });

  @override
  State<TimeRequestedSection> createState() => _TimeRequestedSectionState();
}

class _TimeRequestedSectionState extends State<TimeRequestedSection> {
  @override
  Widget build(BuildContext context) {
    var timeOffProvider =
        Provider.of<TimeOffRequestProvider>(context, listen: true);
    var units = timeOffProvider.getCurrentTimeOffId() != null
        ? TimeOffHoursController().textByUnits(timeOffProvider.timeOff)['unit']
        : '';
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const TitleAndDescription(
              title: 'Time Requested',
              description:
                  'Enter the days or hours according to the selected Time Off.',
            ),
            const SizedBox(height: 24),
            CustomTextFormField(
              ctrl: timeOffProvider.timeCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              labelText: units,
              hintText: units,
              enabled: timeOffProvider.enableTextformfields,
              validation: (value) {
                if (value != null && value == '') {
                  return 'Please fill out the field';
                }
                if (TimeOffValidatorsController()
                    .notValidRequestedTime(value)) {
                  return 'Valid number is required, only numbers allowed';
                }
                if (timeOffProvider.timeOff.timeUnit == 'hrs') {
                  if (timeOffProvider.errors['maxTime'] ||
                      timeOffProvider.maxHours <
                          int.parse(timeOffProvider.timeCtrl.text)) {
                    return 'Hours requested cannot exceed ${timeOffProvider.maxHours} for the selected date range.';
                  }
                  if (timeOffProvider.errors['minTime'] ||
                      (timeOffProvider.daysInRange >
                          int.parse(timeOffProvider.timeCtrl.text)) ||
                      int.parse(timeOffProvider.timeCtrl.text) == 0) {
                    return 'At least 1 hour must be required for every day selected.';
                  }
                }
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+')),
              ],
              myFocusNode: widget.myFocusNode,
              readOnly:
                  timeOffProvider.timeOff.timeUnit == 'days' ? true : false,
            )
          ],
        ));
  }
}
