import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

simpleShowCalendarDatePicker2Dialog({
  context,
  firstDate,
  currentDate,
  initialValue,
  weekdays,
  lastDay,
}) async {
  return await showCalendarDatePicker2Dialog(
    context: context,
    dialogSize: Size(MediaQuery.of(context).size.width * 0.9,
        MediaQuery.of(context).size.height * .5),
    config: CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.single,
      firstDate: firstDate,
      currentDate: currentDate ?? DateTime.now(),
      lastDate: lastDay,
      weekdayLabelTextStyle: TypographyTheme.fontH5,
      lastMonthIcon: const Icon(
        Icons.arrow_back_ios,
        color: ColorsTheme.textColor,
      ),
      nextMonthIcon: const Icon(
        Icons.arrow_forward_ios,
        color: ColorsTheme.textColor,
      ),
      controlsTextStyle: TypographyTheme.fontH5,
      dayTextStyle: TypographyTheme.fontBody3,
      selectedDayTextStyle: TypographyTheme.fontBody1CalendarWhite,
      selectedDayHighlightColor: ColorsTheme.primaryBlue,
      selectedYearTextStyle: TypographyTheme.fontBody1CalendarWhite,
      yearTextStyle: TypographyTheme.fontH5,
      dayBorderRadius: BorderRadius.circular(10),
      yearBorderRadius: BorderRadius.circular(10),
      cancelButtonTextStyle: TypographyTheme.fontH5PrimaryBlue,
      okButtonTextStyle: TypographyTheme.fontH5PrimaryBlue,
      selectableDayPredicate: (day) {
        if (weekdays != null && weekdays) {
          return day.weekday == 6 || day.weekday == 7 ? false : true;
        }
        return true;
      },
    ),
    initialValue: [
      initialValue,
    ],
    borderRadius: BorderRadius.circular(15),
    dialogBackgroundColor: ColorsTheme.white,
  );
}
