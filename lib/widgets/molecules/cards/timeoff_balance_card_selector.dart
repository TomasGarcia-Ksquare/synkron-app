import 'package:flutter/material.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/widgets/molecules/cards/timeoff_balance_card.dart';
import 'package:synkron_app/widgets/molecules/cards/timeoff_balance_gray_card.dart';

class TimeOffBalanceCardSelector extends StatelessWidget {
  final EmployeeTimeOffModel timeoff;
  const TimeOffBalanceCardSelector({super.key, required this.timeoff});

  @override
  Widget build(BuildContext context) {
    return timeoff.temporalRemainder == 0
        ? TimeOffBalanceGrayCard(timeoff: timeoff)
        : TimeOffBalanceCard(timeoff: timeoff);
  }
}
