import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:flutter/material.dart';

class CalendarPickerDateRange{


  Future<List<DateTime?>?> showDateRangeDialog (BuildContext context, double width, double height, List<DateTime?>? resultsDateRange){
    return showCalendarDatePicker2Dialog(
                              context: context,
                              config:
                                  CalendarDatePicker2WithActionButtonsConfig(
                                calendarType: CalendarDatePicker2Type.range,

                                //calendar style
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
                                selectedDayTextStyle:
                                    TypographyTheme.fontBody1CalendarWhite,
                                selectedDayHighlightColor:
                                    ColorsTheme.primaryBlue,
                                selectedYearTextStyle:
                                    TypographyTheme.fontBody1CalendarWhite,

                                yearTextStyle: TypographyTheme.fontH5,
                                dayBorderRadius: BorderRadius.circular(10),
                                yearBorderRadius: BorderRadius.circular(10),
                                cancelButtonTextStyle:
                                    TypographyTheme.fontH5PrimaryBlue,
                                okButtonTextStyle:
                                    TypographyTheme.fontH5PrimaryBlue,
                              ),
                              dialogSize: Size(width * 0.9, height * .5),
                              initialValue: resultsDateRange ?? [],
                              borderRadius: BorderRadius.circular(15),
                              dialogBackgroundColor: ColorsTheme.white,
                            );
  }




}