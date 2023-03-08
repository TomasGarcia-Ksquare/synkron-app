import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_request_provider.dart';
import 'package:synkron_app/widgets/molecules/time_off/time_off_card_selectable.dart';

class TimeOffTypes extends StatelessWidget {
  const TimeOffTypes({super.key});

  @override
  Widget build(BuildContext context) {
    var timeOffProvider =
        Provider.of<TimeOffRequestProvider>(context, listen: true);
    return SliverPadding(
      padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            EmployeeTimeOffModel currentTimeOff =
                timeOffProvider.timeOffAvailable[index];
            return Column(
              children: [
                TimeOffCardSelectable(
                  currentTimeoff: currentTimeOff,
                  padding: const EdgeInsets.all(10),
                  groupValue: timeOffProvider.getCurrentTimeOffId(),
                  onChanged: (value) {
                    timeOffProvider.setCurrentTimeOff(currentTimeOff.benefitId);
                  },
                ),
              ],
            );
          },
          childCount: timeOffProvider.timeOffAvailable.length,
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisExtent: 152,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 156 / 152,
        ),
      ),
    );
  }
}
