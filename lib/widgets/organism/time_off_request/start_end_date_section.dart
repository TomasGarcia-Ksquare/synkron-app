import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_request_provider.dart';
import 'package:synkron_app/widgets/molecules/text/title_and_description.dart';
import 'package:synkron_app/widgets/molecules/textformfield/text_form_field_with_datepicker.dart';

class StartEndDateSection extends StatefulWidget {
  const StartEndDateSection({super.key});

  @override
  State<StartEndDateSection> createState() => _StartEndDateSectionState();
}

class _StartEndDateSectionState extends State<StartEndDateSection> {
  @override
  Widget build(BuildContext context) {
    var timeOffProvider =
        Provider.of<TimeOffRequestProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<TimeOffRequestProvider>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleAndDescription(
                title: 'Start & End Date',
                description:
                    'Select the day or range of days that you want to take off.',
              ),
              const SizedBox(height: 24),
              TextformfieldWithDatepicker(
                  labelText: 'Start date',
                  hintText: 'Start date',
                  validation: (value) {
                    if (!timeOffProvider.validDateRange) {
                      return 'Start date must be smaller than or equal to End date';
                    }
                    return null;
                  },
                  suffixIcon: SvgPicture.asset(
                    'assets/icons/Calendar.svg',
                    height: 30,
                    width: 18,
                    fit: BoxFit.none,
                  ),
                  ctrl: timeOffProvider.startDateCtrl,
                  enabled: timeOffProvider.enableTextformfields,
                  weekdays: true,
                  initalValue: timeOffProvider.startInitialValue),
              const SizedBox(height: 32),
              TextformfieldWithDatepicker(
                labelText: 'End date',
                hintText: 'End date',
                validation: (value) {
                  if (!timeOffProvider.validDateRange) {
                    return 'End date must be greater than or equal to Start date';
                  }

                  if (timeOffProvider.isValidSelectedRange() != null &&
                      timeOffProvider.isValidSelectedRange() == false) {
                    return 'Date should not be after maximal date';
                  }

                  return null;
                },
                suffixIcon: SvgPicture.asset(
                  'assets/icons/Calendar.svg',
                  height: 30,
                  width: 18,
                  fit: BoxFit.none,
                ),
                ctrl: timeOffProvider.endDateCtrl,
                enabled: timeOffProvider.enableTextformfields,
                weekdays: true,
                lastDay: timeOffProvider.lastTimeOffDay,
                firstDate: timeOffProvider.startInitialValue,
                initalValue: timeOffProvider.endInitialValue,
              )
            ],
          );
        },
      ),
    );
  }
}
