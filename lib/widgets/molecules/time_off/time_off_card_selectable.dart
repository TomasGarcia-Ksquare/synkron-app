import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/widgets/atoms/radio/custom_radio.dart';
import 'package:synkron_app/widgets/molecules/time_off/time_off_card.dart';

class TimeOffCardSelectable extends StatelessWidget {
  const TimeOffCardSelectable({
    super.key,
    required this.padding,
    required this.groupValue,
    // required this.value,
    required this.onChanged,
    // required this.displayName,
    required this.currentTimeoff,
  });

  final EdgeInsets padding;
  final dynamic groupValue;
  // final int value;
  final ValueChanged<int> onChanged;
  // final String displayName;
  final EmployeeTimeOffModel currentTimeoff;

  @override
  Widget build(BuildContext context) {
    int value = currentTimeoff.benefitId!;
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Stack(
        children: <Widget>[
          TimeOffCard(
            currentTimeoff: currentTimeoff,
            displayName: currentTimeoff.displayName.toString(),
            icon: currentTimeoff.iconName.toString(),
            value: value,
            selected: value == groupValue,
          ),
          Positioned(
            top: 14,
            left: 14,
            child: CustomRadio(
                value: value, groupValue: groupValue, onChanged: onChanged),
          )
        ],
      ),
    );
  }
}
