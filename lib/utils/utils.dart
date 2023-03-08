// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

class Utils {
  static String formatDate({required String date, required String format}) {
    return DateFormat(format).format(DateTime.parse(date));
  }
}

class DateFormatInterface {
  static const String MM_DD_YYY = 'MM/dd/yyyy';
  static const String MM_DD_YY = 'MM/dd/yy';
  static const String DD_MM_YY_HH_MM_A = 'MMM dd, yyy - hh:mm a';
}

//How to use the formatDate method:
// Utils.formatDate(date: '2021-09-01', format: DateFormatInterface.MM_DD_YY);
