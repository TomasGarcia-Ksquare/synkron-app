import 'package:intl/intl.dart';
import 'package:synkron_app/extensions/camel_case_extension.dart';
import 'package:synkron_app/models/employee/employee_timeoff_model.dart';
import 'package:synkron_app/utils/utils.dart';

class TimeOffHoursController {
  textByUnits(EmployeeTimeOffModel current) {
    var notRequestedHrs = current.availableHours! - current.requestedHours!;
    switch (current.timeUnit) {
      case 'days':
        var value = notRequestedHrs / 8;
        return {
          'desc': '$value days available'.replaceAll('.0', ''),
          'unit': 'days'.capitalize(),
        };
      case 'hrs':
        var value = notRequestedHrs;
        return {
          'desc':
              '$value hours available ${current.renewalDate != null ? "due ${current.renewalDate}" : ""}',
          'unit': 'hours'.capitalize(),
        };
      default:
        return 0;
    }
  }

  List<DateTime> getWeekdaysBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> weekdays = [];
    for (var day = startDate;
        day.isBefore(endDate.add(const Duration(days: 1)));
        day = day.add(const Duration(days: 1))) {
      if (day.weekday >= DateTime.monday && day.weekday <= DateTime.friday) {
        weekdays.add(day);
      }
    }
    return weekdays;
  }

  getLastDay(DateTime start, num days) {
    num availableDays = days;
    var count = 0;
    var day = start;
    while (availableDays > 0) {
      if (day.weekday >= DateTime.monday && day.weekday <= DateTime.friday) {
        availableDays--;
      }
      count++;
      day = day.add(const Duration(days: 1));
    }
    return getWeekdaysBetween(start, start.add(Duration(days: count - 1)));
  }

  stringToDate(String date) {
    return DateFormat('MM/dd/yy').parse(date);
  }

  formatRenewalDate(date) {
    if (date == null) return '';
    return Utils.formatDate(date: date, format: DateFormatInterface.MM_DD_YYY);
  }
}
